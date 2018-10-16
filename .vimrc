"execute pathogen#infect()
call plug#begin('~/.vim/plugged')
"call vundle#begin('~/some/path/here')

" Keep Plugin commands between vundle#begin/end.
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
"Plug 'aceofall/gtags.vim'

Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plugin 'Valloric/YouCompleteMe'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
Plug 'https://github.com/vim-scripts/taglist.vim.git'

" Add maktaba and codefmt to the runtimepath.
" " (The latter must be installed before it can be used.)
"Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
" " Also add Glaive, which is used to configure codefmt's maktaba flags. See
" " `:help :Glaive` for usage.
"Plug 'google/vim-glaive'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call plug#end()            " required
" Put your non-Plugin stuff after this line
" the glaive#Install() should go after the "call vundle#end()"
"call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
"Glaive codefmt plugin[mappings]
"Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

"augroup autoformat_settings
"    autocmd FileType bzl AutoFormatBuffer buildifier
"    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"    autocmd FileType dart AutoFormatBuffer dartfmt
"    autocmd FileType go AutoFormatBuffer gofmt
"    autocmd FileType gn AutoFormatBuffer gn
"    autocmd FileType html,css,json AutoFormatBuffer js-beautify
"    autocmd FileType java AutoFormatBuffer google-java-format
"    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer
    " autopep8
"augroup END

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
highlight CTagsGlobalVariable ctermfg=5 cterm=bold

highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}|

set nocompatible              " be iMproved, required
set incsearch
set hlsearch
set laststatus=2
"set tw=78 fo+=Mm
set tabstop=4
set shiftwidth=4
set expandtab
set history=100
"set cindent
set smartindent
set showtabline=2
"set ai!
set autoread
" set nocscopetag
filetype on

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
let g:fzf_command_prefix = 'Fzf'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Auto_Open=1
let Tlist_Ctags_Cmd="ctags-local"
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
set tags=./tags,tags,./TAGS;$HOME
syntax on
"set autochdir
set nu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
"let g:ctrlp_working_path_mode = 'w'
"let g:ctrlp_max_files = 0
"let g:ctrlp_cache_dir = $PWD.'/.cache/ctrlp'
"let g:ctrlp_clear_cache_on_exit = 1
"let g:ctrlp_by_filename = 0
"let g:ctrlp_follow_symlinks = 1
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'
"let g:ctrlp_use_caching = 1
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

"if executable('/home/oops/cquery/work-cquery/bin/cquery')
"   au User lsp_setup call lsp#register_server({
"    \ 'name': 'cquery',
"    \ 'cmd': {server_info->['cquery']},
"    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"    \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
"    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"    \ })
"endif

if has("cscope")
    set csprg=/usr/bin/cscope
    "set cscopequickfix=s-,c-,d-,i-,t-,e-
    set cscopetag
    set csto=0
    set cst
    set nocsverb
    set cspc=5
    "add any database in current dir
    "if filereadable("GTAGS")
    if filereadable("cscope.out")
        "let cscope_file=findfile("GTAGS", ".;")
        let cscope_file=findfile("cscope.out", ".;")
        let cscope_pre = system("pwd")
        let cscope_pre = strpart(cscope_pre,0,strlen(cscope_pre) - 1)
        if !empty(cscope_file) && filereadable(cscope_file)
            exe "cs add" cscope_file cscope_pre
        endif
    endif
endif
let mapleader="."
" cS delete space at end of line
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" delete ^M character
nmap cM :%s/\r$//g<CR>:noh<CR>
nmap <F7> :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F8> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F9> :NERDTreeFind<CR>
nmap <silent> <leader>df :Gvdiff<CR>
nmap <silent> <leader>ff :FzfFiles<CR>
nmap <silent> <leader>fb :FzfBuffers<CR>
nmap <silent> <leader>ft :FzfBTags<CR>
nmap <silent> <leader>fT :FzfTags<CR>
nmap <silent> <leader>fs :FzfBLines<CR>
nmap <silent> <leader>fd :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <leader>ss :Ack! <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F5> :!cscope -Rqb<CR>:cs reset<CR><CR>
nmap <F3> :cnext<CR>
nmap <F4> :cpre<CR>

imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
