#!/usr/bin/env bash

readonly BASEDIR=$(readlink -f $(dirname $0))/..
cd $BASEDIR

# exit on errors
set -e

if ! hash nproc 2>/dev/null; then

	function nproc() {
		echo 8
	}

fi

function version_lt() {
	[ $(echo -e "$1\n$2" | sort -V | head -1) != "$1" ]
}

rc=0

echo -n "Checking file permissions..."

while read -r perm _res0 _res1 path; do
	if [ ! -f "$path" ]; then
		continue
	fi

	fname=$(basename -- "$path")

	case ${fname##*.} in
	c | h | cpp | cc | cxx | hh | hpp | md | html | js | json | svg | Doxyfile | yml | LICENSE | README | conf | in | Makefile | mk | gitignore | go | txt)
		# These file types should never be executable
		if [ "$perm" -eq 100755 ]; then
			echo "ERROR: $path is marked executable but is a code file."
			rc=1
		fi
		;;
	*)
		shebang=$(head -n 1 $path | cut -c1-3)

		# git only tracks the execute bit, so will only ever return 755 or 644 as the permission.
		if [ "$perm" -eq 100755 ]; then
			# If the file has execute permission, it should start with a shebang.
			if [ "$shebang" != "#!/" ]; then
				echo "ERROR: $path is marked executable but does not start with a shebang."
				rc=1
			fi
		else
			# If the file doesnot have execute permissions, it should not start with a shebang.
			if [ "$shebang" = "#!/" ]; then
				echo "ERROR: $path is not marked executable but starts with a shebang."
				rc=1
			fi
		fi
		;;
	esac

done <<<"$(git grep -I --name-only --untracked -e . | git ls-files -s)"

if [ $rc -eq 0 ]; then
	echo " OK"
fi

if hash clang-format; then
	echo -n "Checking coding style..."
	CLANG_FORMAT_VERSION=$(clang-format --version | cut -d ' ' -f3)
	if version_lt "9.0.0" "${CLANG_FORMAT_VERSION}"; then
		echo -n " Your clang-format version is too old so skipping coding style checks. Please update clang-format to at least 10.0.0 version..."
	else
		rm -f clang-format.log
		touch clang-format.log

		#  coding standards.
		SOURCE_FILES=$(git ls-files '*.[ch]' '*.cpp' '*.cc' '*.cxx' '*.hh' '*.hpp')
		for source_file in ${SOURCE_FILES}; do
			clang-format --output-replacements-xml ${source_file} >clang-format.log
			if grep -q -w '\(offset=\|length=\)' clang-format.log; then
				echo "File   ${source_file}   need format"
				rc=1
			else
				echo "Checking  ${source_file}  OK"
			fi
		done
		rm -f clang-format.log
	fi
else
	echo "You do not have clang-format installed so your code style is not being checked!"
fi

GIT_VERSION=$(git --version | cut -d' ' -f3)

if version_lt "1.9.5" "${GIT_VERSION}"; then
	# git <1.9.5 doesn't support pathspec magic exclude
	echo " Your git version is too old to perform all tests. Please update git to at least 1.9.5 version..."
	exit 0
fi

echo -n "Checking comment style..."

git grep --line-number -e '/[*][^ *-]' -- '*.[ch]' >comment.log || true
git grep --line-number -e '[^ ][*]/' -- '*.[ch]' ':!lib/rte_vhost*/*' >>comment.log || true
git grep --line-number -e '^[*]' -- '*.[ch]' >>comment.log || true
git grep --line-number -e '\s//' -- '*.[ch]' >>comment.log || true
git grep --line-number -e '^//' -- '*.[ch]' >>comment.log || true

if [ -s comment.log ]; then
	echo " Incorrect comment formatting detected"
	cat comment.log
	rc=1
else
	echo " OK"
fi
rm -f comment.log

echo -n "Checking for spaces before tabs..."
git grep --line-number $' \t' -- './*' ':!*.patch' >whitespace.log || true
if [ -s whitespace.log ]; then
	echo " Spaces before tabs detected"
	cat whitespace.log
	rc=1
else
	echo " OK"
fi
rm -f whitespace.log

echo -n "Checking trailing whitespace in output strings..."

git grep --line-number -e ' \\n"' -- '*.[ch]' >whitespace.log || true

if [ -s whitespace.log ]; then
	echo " Incorrect trailing whitespace detected"
	cat whitespace.log
	rc=1
else
	echo " OK"
fi
rm -f whitespace.log

echo -n "Checking for use of forbidden library functions..."

git grep --line-number -w '\(atoi\|atol\|atoll\|strncpy\|strcpy\|strcat\|sprintf\|vsprintf\)' -- './*.c' ':!lib/rte_vhost*/**' >badfunc.log || true
if [ -s badfunc.log ]; then
	echo " Forbidden library functions detected"
	cat badfunc.log
	rc=1
else
	echo " OK"
fi
rm -f badfunc.log

echo -n "Checking blank lines at end of file..."

if ! git grep -I -l -e . -z './*' ':!*.patch' |
	xargs -0 -P$(nproc) -n1 scripts/eofnl >eofnl.log; then
	echo " Incorrect end-of-file formatting detected"
	cat eofnl.log
	rc=1
else
	echo " OK"
fi
rm -f eofnl.log

if hash pycodestyle 2>/dev/null; then
	PEP8=pycodestyle
elif hash pep8 2>/dev/null; then
	PEP8=pep8
fi

if [ -n "${PEP8}" ]; then
	echo -n "Checking Python style..."

	PEP8_ARGS+=" --max-line-length=140"

	error=0
	PYTHON_FILES=$(git ls-files '*.py')
	for py_file in ${PYTHON_FILES}; do
		$PEP8 $PEP8_ARGS ${py_file} >pep8.log || error=1
		if [ $error -ne 0 ]; then
			echo " Python formatting errors detected"
			cat pep8.log
			rc=1
		else
			echo " OK"
		fi
	done
	rm -f pep8.log
else
	echo "You do not have pycodestyle or pep8 installed so your Python style is not being checked!"
fi

if hash shellcheck 2>/dev/null; then
	echo -n "Checking Bash style..."

	shellcheck_v=$(shellcheck --version | grep -P "version: [0-9\.]+" | cut -d " " -f2)

	# SHCK_EXCLUDE contains a list of all of the spellcheck errors found in SPDK scripts
	# currently. New errors should only be added to this list if the cost of fixing them
	# is deemed too high. For more information about the errors, go to:
	# https://github.com/koalaman/shellcheck/wiki/Checks
	# Error descriptions can also be found at: https://github.com/koalaman/shellcheck/wiki
	# SPDK fails some error checks which have been deprecated in later versions of shellcheck.
	# We will not try to fix these error checks, but instead just leave the error types here
	# so that we can still run with older versions of shellcheck.
	SHCK_EXCLUDE="SC1117"
	# SPDK has decided to not fix violations of these errors.
	# We are aware about below exclude list and we want this errors to be excluded.
	# SC1083: This {/} is literal. Check expression (missing ;/\n?) or quote it.
	# SC1090: Can't follow non-constant source. Use a directive to specify location.
	# SC1091: Not following: (error message here)
	# SC2001: See if you can use ${variable//search/replace} instead.
	# SC2010: Don't use ls | grep. Use a glob or a for loop with a condition to allow non-alphanumeric filenames.
	# SC2015: Note that A && B || C is not if-then-else. C may run when A is true.
	# SC2016: Expressions don't expand in single quotes, use double quotes for that.
	# SC2034: foo appears unused. Verify it or export it.
	# SC2046: Quote this to prevent word splitting.
	# SC2086: Double quote to prevent globbing and word splitting.
	# SC2119: Use foo "$@" if function's $1 should mean script's $1.
	# SC2120: foo references arguments, but none are ever passed.
	# SC2148: Add shebang to the top of your script.
	# SC2153: Possible Misspelling: MYVARIABLE may not be assigned, but MY_VARIABLE is.
	# SC2154: var is referenced but not assigned.
	# SC2164: Use cd ... || exit in case cd fails.
	# SC2174: When used with -p, -m only applies to the deepest directory.
	# SC2206: Quote to prevent word splitting/globbing,
	#         or split robustly with mapfile or read -a.
	# SC2207: Prefer mapfile or read -a to split command output (or quote to avoid splitting).
	# SC2223: This default assignment may cause DoS due to globbing. Quote it.
	SHCK_EXCLUDE="$SHCK_EXCLUDE,SC1083,SC1090,SC1091,SC2010,SC2015,SC2016,SC2034,SC2046,SC2086,\
SC2119,SC2120,SC2148,SC2153,SC2154,SC2164,SC2174,SC2001,SC2206,SC2207,SC2223"

	SHCK_FORMAT="diff"
	SHCK_APPLY=true
	if [ "$shellcheck_v" \< "0.7.0" ]; then
		SHCK_FORMAT="tty"
		SHCK_APPLY=false
	fi
	SHCH_ARGS=" -x -e $SHCK_EXCLUDE -f $SHCK_FORMAT"

	error=0
	git ls-files '*.sh' | xargs -P$(nproc) -n1 shellcheck $SHCH_ARGS &>shellcheck.log || error=1
	if [ $error -ne 0 ]; then
		echo " Bash formatting errors detected!"

		# Some errors are not auto-fixable. Fall back to tty output.
		if grep -q "Use another format to see them." shellcheck.log; then
			SHCK_FORMAT="tty"
			SHCK_APPLY=false
			SHCH_ARGS=" -e $SHCK_EXCLUDE -f $SHCK_FORMAT"
			git ls-files '*.sh' | xargs -P$(nproc) -n1 shellcheck $SHCH_ARGS >shellcheck.log || error=1
		fi

		cat shellcheck.log
		if $SHCK_APPLY; then
			git apply shellcheck.log
			echo "Bash errors were automatically corrected."
			echo "Please remember to add the changes to your commit."
		fi
		rc=1
	else
		echo " OK"
	fi
	rm -f shellcheck.log
else
	echo "You do not have shellcheck installed so your Bash style is not being checked!"
fi

exit $rc
