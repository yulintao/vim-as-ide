# vim-as-ide

使用方法：
```
sudo apt install cscope ctags clang-format
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
             https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

打开vim,输入命令:PlugInstall

找到一份代码，然后执行
ctags --c-kinds=+lpx --languages=all --fields=+iaS -R
cscope -Rqb
系统安装fd,universal-ctags,ag
apt-get install silversearcher-ag
https://github.com/universal-ctags/ctags.git
https://github.com/sharkdp/fd/releases/download/v7.1.0/fd-musl_7.1.0_amd64.deb
https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb

或者使用
pacman -Ss global
gtags


使用Leaderf的时候需要global 的版本大于 6.6.5
gtags 使用.globalrc 文件作为配置文件，需要忽略的目录在skip后面添加，最后以：结尾
```

# 这部分需要添加到.bashrc中

```
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse "

```
这里面是放到FZF OPTS中的preview，目前暂时不需要
--preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'
```

需要进行忽略的目录或者文件都放到.gitignore里面

if [ "$TERM"="linux" ] ;then
export LANG="en_US.UTF-8"
fi

# vim 与 tmux 配色不一致问题
alias tmux='tmux -2'

# 开发调试相关
export EXTRA_CFLAGS="-O0 -ggdb3"
export CFLAGS="-O0 -ggdb3 "
export RTE_SDK=/home/`whoami`/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export LD_LIBRARY_PATH=/home/`whoami`/dpdk/x86_64-native-linuxapp-gcc/lib
export PKG_CONFIG_PATH=/home/`whoami`/dpdk/x86_64-native-linuxapp-gcc/lib/pkgconfig

export PATH="$PATH:/home/`whoami`/universal-ctags/ctags-work/bin"

```

# 快捷键

```
主要的快捷键都在vimrc文件中
leader       定义为,
vim 		 用ctrlp忽略搜索的目录是在当前的目录里面建立一个隐藏目录，.gitignore然后把需要忽略的内哦那个添加到里面
ctrl ]		 跳到函数定义
ctrl o 		 后跳 ctrl i 前跳
V		大写`v`表示选中整行
ctrl hjkl 	 分别为光标定位到不同的窗口
f7/8		 搜索光标处函数的引用位置

vs		竖切窗口
sp		横切窗口
botright	竖切窗口时将新建的窗口放到右边
topleft		横切窗口时将新建的窗口放到下面
例如：botright vs


Ctrl W ] 用新窗口预览
Ctrl W } 使用preview窗口预览
leader gs 查找符号位置
leader gc 查找符号调用位置
leader gg 查找符号定义位置

上面搜索出来之后，光标直接定位到quickfix窗口，在下面选择一个按P就可以打开快速预览
Ctrl - W + z 关闭预览窗口
leader qo 打开quickfix列表
leader qc 关闭quickfix列表

ta flags 		查找flags这个位置
shift * 		高亮向后查找
shift # 		高亮向前查找
gd 		跳转到本地局部变量定义位置
w		向右移动一个单词的距离
b		向左移动一个单词的距离
L		当前屏幕的底部
H		当前屏幕的顶部
M		当前屏幕的中部
z t/ENTER 	当前行移动到屏幕顶端
z z/.		当前行移动到屏幕中间
z b/- 		当前行移动到屏幕底端
ctrl e		向下移动一行
ctrl y 		向上移动一行
ctrl f / b	向下/上滚动一屏
ctrl d /u 	向下/上滚动半屏
nohls		 取消查找选择高亮
%		括号跳转包括（）{}
m x		在当前位置打一个标记x，等需要跳回这个位置的时候直接按 'x 即可，跳回现在为止按 ''
		m+X 定义全局的标记，查看标记用Marks
{}()		跳转到一个自然段的开头和结尾
,tm		启用图表快速格式（dhruvasagar/vim-table-mode）插件
,tdc		图表快速删除列
,tdd		图表快速删除行
,tic[C]		当前列表后[前]插入一列图表
,tr		图表重新格式化
画图方法,首先开启画图模式',tm' 然后输入'|'画方格，然后输入字符，回车后，输入两次'||'画中间分割线
|-----------|------------|
| akjfl;afd | laj;dlfja; |
|-----------|------------|

drawit使用方法，直接输入:DIstart/Distop开启画图或者关闭画图，其余查看help
-------------------------------
vim 同时打开多个文件的编辑方法
buffers 查看都有哪些文件
:bn 下一个文件
:bp 上一个文件
:b 文件名   打开对应文件

zo 打开一个折叠。
zc 关闭一个折叠。
za 当关闭时打开，当打开时关闭。
zo、zc、za 对应 zO、zC 和 zA；以递归形式改变折叠状态。
zR 打开全部折叠。
zM 关闭全部折叠。

```
# 快速选择

```
# 快速选择
ci'、ci"、ci(、ci[、ci{、ci< - 分别更改这些配对标点符号中的文本内容
di'、di"、di(或dib、di[、di{或diB、di< - 分别删除这些配对标点符号中的文本内容
yi'、yi"、yi(、yi[、yi{、yi< - 分别复制这些配对标点符号中的文本内容
vi'、vi"、vi(、vi[、vi{、vi< - 分别选中这些配对标点符号中的文本内容
```

# vimdiff 快捷键
```
dp 当前文件内容复制到另外一个文件
do 将另外一个文件的内容复制到当前文件
zo 展开折叠的内容
zc 折叠内容
]c 跳转到下一个差异点
[c 跳转到上一个差异点

```
# nerdComNestedComment 注释
```
<leader>ca 表示切换注释为// 或者 /**/
<leader>ci 插入注释
<leader>cs smart注释
<leader>cm 代码块注释
<leader>cA 在代码后面加注释
<leader>cu 取消注释

```

# 下面这部分主要是NERDTree插件的快捷方式

```

o       在已有窗口中打开文件、目录或书签，并跳到该窗口
go      在已有窗口 中打开文件、目录或书签，但不跳到该窗口
t       在新 Tab 中打开选中文件/书签，并跳到新 Tab
T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab
i       split 一个新窗口打开选中文件，并跳到该窗口
gi      split 一个新窗口打开选中文件，但不跳到该窗口
s       vsplit 一个新窗口打开选中文件，并跳到该窗口
gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口
!       执行当前文件
O       递归打开选中 结点下的所有目录
x       合拢选中结点的父目录
X       递归 合拢选中结点下的所有目录
e       Edit the current dif

双击    相当于 NERDTree-o
中键    对文件相当于 NERDTree-i，对目录相当于 NERDTree-e

D       删除当前书签

P       跳到根结点
p       跳到父结点
K       跳到当前目录下同级的第一个结点
J       跳到当前目录下同级的最后一个结点
k       跳到当前目录下同级的前一个结点
j       跳到当前目录下同级的后一个结点

C       将选中目录或选中文件的父目录设为根结点
u       将当前根结点的父目录设为根目录，并变成合拢原根结点
U       将当前根结点的父目录设为根目录，但保持展开原根结点
r       递归刷新选中目录
R       递归刷新根结点
m       显示文件系统菜单 #！！！然后根据提示进行文件的操作如新建，重命名等
cd      将 CWD 设为选中目录

I       切换是否显示隐藏文件
f       切换是否使用文件过滤器
F       切换是否显示文件
B       切换是否显示书签

q       关闭 NerdTree 窗口
?       切换是否显示 Quick Help

:tabnew [++opt选项] ［＋cmd］ 文件      建立对指定文件新的tab
:tabc   关闭当前的 tab
:tabo   关闭所有其他的 tab
:tabs   查看所有打开的 tab
:tabp   前一个 tab
:tabn   后一个 tab

```

# 其他部分
```
部分代码缩进：

首先移动到行首，然后按住ctrl+v进入可视块模式，使用j,k选择要进行调整的代码，然后按数字2然后按 > 向右缩进2个字符，其他操作同理


选择复制：

先按v然后按往下的键j一直到需要复制的地方，然后按y，然后到需要粘贴的地方按p


记录重复的操作

先按qa意思是通过a记录接下来的操作，按完qa以后接下来按需要的操作，然后按q结束记录，然后按@a重复刚刚记录的操

替换一个单词：

首先找到需要拷贝的单词然后按v+e+y拷贝，然后到需要粘贴的地方按v+e+p粘贴

```

# 可选部分

`:CurrentFormatter`查看当前的format程序

```
修改c程序函数的颜色

修改的文件位置为/usr/share/vim/vim74/syntax/c.vim,在最下面加入下面代码

"highlight Functions
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions term=bold cterm=bold ctermfg=darkcyan
syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
hi cClass cterm=bold ctermfg=lightgreen

默认使用 clang-format 格式化代码，如果不希望使用可以将这部分在vimrc 中注释掉

augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer
    " autopep8
augroup END

```
