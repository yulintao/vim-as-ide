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
```

# 快捷键
```
主要的快捷键都在vimrc文件中
leader       定义为.
vim 		 用ctrlp忽略搜索的目录是在当前的目录里面建立一个隐藏目录，.gitignore然后把需要忽略的内哦那个添加到里面
ctrl ]		 跳到函数定义
ctrl o 		 后跳 ctrl i 前跳
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
```

部分代码缩进：


首先移动到行首，然后按住ctrl+v进入可视块模式，使用j,k选择要进行调整的代码，然后按数字2然后按 > 向右缩进2个字符，其他操作同理


选择复制：


先按v然后按往下的键j一直到需要复制的地方，然后按y，然后到需要粘贴的地方按p


记录重复的操作


先按qa意思是通过a记录接下来的操作，按完qa以后接下来按需要的操作，然后按q结束记录，然后按@a重复刚刚记录的操

替换一个单词： 

首先找到需要拷贝的单词然后按v+e+y拷贝，然后到需要粘贴的地方按v+e+p粘贴

#可选部分

修改c程序函数的颜色


修改的文件位置为/usr/share/vim/vim74/syntax/c.vim,在最下面加入下面代码
```
"highlight Functions
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions term=bold cterm=bold ctermfg=darkcyan
syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
hi cClass cterm=bold ctermfg=lightgreen
```
默认使用 clang-format 格式化代码，如果不希望使用可以将这部分在vimrc 中注释掉
```
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
