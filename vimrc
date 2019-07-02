" 插件开始位置
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
"Plug 'aceofall/gtags.vim'

Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'Valloric/YouCompleteMe'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

Plug 'https://github.com/vim-scripts/taglist.vim.git'
"Plug 'Chiel92/vim-autoformat'

Plug 'terryma/vim-multiple-cursors'

" commenter
Plug 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call plug#end()            " required

" 状态栏
function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction

set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}|

" 高亮
highlight CTagsGlobalVariable ctermfg=5 cterm=bold
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE

" auto format
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0
"au BufWrite * :Autoformat
"autocmd  BufReadPost,FileReadPost   *.[ch]  :silent %!indent -l0 -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1

" 高亮鼠标当前行
set cul
" 高亮鼠标当前列
"set cuc
"set nocompatible              " be iMproved, required
"搜索时高亮
set incsearch
set hlsearch

set laststatus=2
"set tw=78 fo+=Mm

" 设置tab转换成4个空格
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set noexpandtab
set history=1000

" 不备份文件
set nobackup
set noswapfile

" 自动对齐
set cindent
"set autoindent
"set smartindent

" 去掉输入错误的提示音
set noeb

set showtabline=2

" 显示tab和尾部的空格
set listchars=tab:>-,trail:■
"set list

" 回车换行，参数自动对齐到括号
set cino+=(0,w1,{0,0},:0,t0,+10

" 自动保存
set autoread
set autowrite

" 显示行号
set nu

" 忽略目录
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" 设置tags文件路径
set tags+=./TAGS

" 设置vim leader 符号
let mapleader=","

" 插件EasyMotion  操作
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:fzf_command_prefix = 'Fzf'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1

" 自动打开Tlist
"let Tlist_Auto_Open = 1
"let Tlist_Ctags_Cmd="/home/`whoami`/code/universal-ctags/ctags-work/bin/ctags-local"

" To ignore plugin indent changes, instead use:
"filetype plugin on
filetype plugin indent on

" 自动打开上次文件位置，对于c,h文件把tab转换成4个空格
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	au BufRead *.[ch] :set expandtab
	au BufNewFile *.[ch] :set expandtab
endif

syntax on
"set autochdir
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ackprg = 'ag'
endif

if has("cscope")
    set csprg=/usr/bin/cscope
    "set cscopequickfix=s-,c-,d-,i-,t-,e-
    set cscopetag
    set cst
    set csto=0
    set nocsverb
    set cspc=10
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

" cS delete space at end of line
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" delete ^M character
nmap cM :%s/\r$//g<CR>:noh<CR>

nmap <F7> :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F8> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F9> :NERDTreeFind<CR>
nmap fs <Plug>(easymotion-sn)
nmap fj <Plug>(easymotion-j)
nmap fk <Plug>(easymotion-k)
nmap <silent> <leader>df :Gvdiff<CR>
nmap <silent> <leader>ff :FzfFiles<CR>
nmap <silent> <leader>fb :FzfBuffers<CR>
nmap <silent> <leader>ft :FzfBTags<CR>
nmap <silent> <leader>fT :FzfTags<CR>
nmap <silent> <leader>fs :FzfBLines<CR>
nmap <silent> <leader>h :nohls<CR>
nmap <silent> <leader>fd :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <leader>ss :Ack! <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F5> :!cscope -Rqb<CR>:cs reset<CR>
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
