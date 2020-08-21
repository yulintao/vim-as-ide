# 重新载入配置文件

init.el 需要放到~/.emacs.d/ 目录下

quote 相当于 ' (quote foo) == 'foo

M-x load-file  两次回车
M-x eval-buffer 执行缓冲区所有Lisp命令
C-x C-e 执行某一行Lisp代码


添加完插件后的快捷键：
插件位置：https://github.com/tuhdo/emacs-c-ide-demo.git

M-s h . 高亮当前变量
M-s h u 取消高亮
M-. 查找定义和引用的位置
M-, 返回前一个位置
M-s . 查找当前光标下单词位置,找到以后，可以使用C-r/s 继续查找引用位置，其中C-r是反向查找，C-s是正向查找
M-; 注释当前行
M-! 运行一个shell命令，例如查看pwd
M-<[>] 移动到文件头[尾]
M-a[e] 光标移动到段落开头和结尾
M C-a 移动光标到函数的开始处
M C-e 移动光标到函数的结尾处
M C-p 移动光标到括号的开始处
M C-n 移动光标到括号的结尾处
M-g g 跳转到第几行 

M-w 复制当前行
C-w 剪切当前行
C-h k 然后输入组合键显示定义
C-y 粘贴复制的内容
C-, 前一个定义位置
C-. 后一个定义位置
C-c h o 在当前文件中查找字符串
C-c s   在当前文件中查找字符串
C-c g f 查找函数在当前文件中的位置
C-c g r 查找函数引用位置
C-c g d 查找函数定义位置



