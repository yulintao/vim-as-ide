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

```

# 这部分需要添加到.bashrc中

```
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
需要进行忽略的目录或者文件都放到.gitignore里面


export PATH="$PATH:/home/`whoami`/universal-ctags/ctags-work/bin"
export RTE_SDK=$PWD/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc
export LD_LIBRARY_PATH=$PWD

```

# 快捷键
```
主要的快捷键都在vimrc文件中
leader       定义为.
vim 		 用ctrlp忽略搜索的目录是在当前的目录里面建立一个隐藏目录，.gitignore然后把需要忽略的内哦那个添加到里面
ctrl ]		 跳到函数定义
ctrl o 		 后跳 ctrl i 前跳
V		大写`v`表示选中整行
ctrl hjkl 	 分别为光标定位到不同的窗口
f7/8		 搜索光标处函数的引用位置
cs find s xxx 搜索字符串
cs find t xxx 搜索字符串
ta flags 		查找flags这个位置
shift * 		高亮向后查找
shift # 		高亮向前查找
gd 		跳转到本地局部变量定义位置
w		向右移动一个单词的距离
b		向左移动一个单词的距离
ctrl e		向下移动一行
ctrl y 		向上移动一行
ctrl f / b	向下/上滚动一屏
ctrl d /u 	向下/上滚动半屏
nohls		 取消查找选择高亮
%		括号跳转包括（）{}
m x		在当前位置打一个标记x，等需要跳回这个位置的时候直接按 'x 即可，跳回现在为止按 ''
{}()		跳转到一个自然段的开头和结尾
,tm		启用图表快速格式（dhruvasagar/vim-table-mode）插件
,tdc		图表快速删除列
,tdd		图表快速删除行
,tic		插入一列图表
,tr		图表重新格式化

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
