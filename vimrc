" 插件开始位置
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'derekwyatt/vim-fswitch'

" vim color themes
Plug 'kyoz/purify', { 'rtp': 'vim' }

" vim-mark
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

"" Tags use gtags automatic management
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
""Plug 'skywind3000/vim-quickui'
"Plug 'skywind3000/vim-preview'

" markdown 相关
" python 图表
" markdown start
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'SirVer/ultisnips',{'for':'markdown'}
Plug 'honza/vim-snippets'
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" markdown end

" drawit 画图
Plug 'vim-scripts/DrawIt'
" drawit end

"Plug 'junegunn/fzf', { 'dir': '~/.vim/plugged/fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

"Plug 'Valloric/YouCompleteMe'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

Plug 'https://github.com/vim-scripts/taglist.vim.git'
Plug 'Chiel92/vim-autoformat'

"Plug 'terryma/vim-multiple-cursors'

" commenter
Plug 'scrooloose/nerdcommenter'

" highlight start
" async used by vim-lsp
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp' " vim-lsp
"" or
"Plug 'neoclide/coc.nvim' " coc.nvim
"" or
"Plug 'neovim/nvim-lsp' " nvim-lsp
" or
" LanguageClient-neovim
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
""
" Register clangd C++ lanuage server. (Can replaced by vim-lsp-settings)
"Plug 'mattn/vim-lsp-settings'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
" highlight cxx
"Plug 'jackguo380/vim-lsp-cxx-highlight'
" highlight end

" All of your Plugins must be added before the following line
call plug#end()            " required

"" Configuration of LanguageClient-neovim to use ccls with
" ccls start
" also see https://github.com/autozimu/LanguageClient-neovim/wiki/ccls
"let s:ccls_settings = {
"         \ 'highlight': { 'lsRanges' : v:true },
"         \ }

"let s:ccls_command = ['ccls', '-init=' . json_encode(s:ccls_settings)]

"let g:LanguageClient_serverCommands = {
"      \ 'c': s:ccls_command,
"      \ 'cpp': s:ccls_command,
"      \ 'objc': s:ccls_command,
"      \ }

"" ccls end

"" markdown confirguration start
"let g:vim_markdown_frontmatter = 1
"let g:vim_markdown_folding_disabled = 1
"" markdown confirguration end

"" enable gtags module start
"let g:gutentags_modules = ['gtags_cscope']
"" config project root markers.
"let g:gutentags_project_root = ['.root']
"" generate datebases in my cache directory, prevent gtags files polluting my project
"let g:gutentags_cache_dir = expand('~/.cache/tags')
"
"" change focus to quickfix window after search (optional).
"let g:gutentags_plus_switch = 1
"let g:gutentags_plus_nomap = 1
"" enable gtags module end

""gtags 设置项
"set cscopetag " 使用 cscope 作为 tags 命令
"set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
"let GtagsCscope_Auto_Load = 1
"let CtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1
"let gtags_file=findfile("GTAGS", ";")
"if !empty(gtags_file)
"    exe "cs add" gtags_file
"endif


" 只有一个窗口时关闭NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nerdTree end

" auto format start
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" 输出AutoFormat信息
autocmd FileType vim,tex let b:autoformat_autoindent=0

" 高亮
highlight CTagsGlobalVariable ctermfg=5 cterm=bold
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" statusline
function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction

set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}|

" 高亮鼠标当前行
set cul
"搜索时高亮
set incsearch
set hlsearch

" 保存全局变量
set viminfo+=!

set scrolloff=2
set updatetime=300

" 不适用vi 的键盘模式
set nocompatible
set laststatus=2
set history=10000

" 不备份文件
set nobackup
set noswapfile

" 去掉vim滴滴声
set noeb

" 去掉vim 闪烁
set novisualbell

" 语法高亮
syntax enable

" vim color theme start
syntax on " This is required
colorscheme purify
" vim color theme end

" 设置正则表达式
set magic

" vim 右下角显示未完成的命令
set showcmd
" 终端颜色256色
set t_Co=256

set showtabline=2

" 显示tab和尾部的空格
set listchars=tab:>-,trail:■
"set list

" 自动保存
set autoread
set autowrite

" 显示行号
set nu

" 忽略目录
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" 设置TAGS文件路径
"set tags+=./GTAGS
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Use_Right_Window=0
let Tlist_Auto_Update=1

" 设置vim leader 符号
let mapleader=","

" 插件EasyMotion  操作
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:fzf_command_prefix = 'Fzf'

"开启文件类型侦测
filetype on

set nofoldenable

"根据文件类型加载对应插件
filetype plugin indent on

" 自动打开上次文件位置，对于c,h文件把tab转换成4个空格
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	"au BufRead *.[ch] :set expandtab
	"au BufNewFile *.[ch] :set expandtab
endif

autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

"set ack.vim 
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
"set ack.vim end

" cS delete space at end of line
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" delete ^M character
nmap cM :%s/\r$//g<CR>:noh<CR>

"nmap <F3> :cnext<CR>
"nmap <F4> :cpre<CR>
"nmap <silent> <F9> :NERDTreeFind<CR>
"" swap between .c and .h
"nmap <silent> <Leader>sw :FSHere<CR>
"" autoformat
nmap <silent> <Leader>af :Autoformat<CR>:w<CR>
"" git diff 比较当前文件
"nmap <silent> <leader>df :Gvdiff<CR>
"" 快速查找文件
"nmap <silent> <leader>ff :FzfFiles<CR>
"" 在当前缓存区中切换文件
"nmap <silent> <leader>fb :FzfBuffers<CR>
"" 在当前文件中搜索关键字
"nmap <silent> <leader>ft :FzfBTags<CR>
"nmap <silent> <leader>fT :FzfTags<CR>
"nmap <silent> <leader>fs :FzfBLines<CR>
" 查找单个字符
nmap fs <Plug>(easymotion-s)
" 向下移动
nmap fj <Plug>(easymotion-j)
" 向上移动
nmap fk <Plug>(easymotion-k)

" 取消高亮
nmap <silent> <leader>h :nohls<CR>

imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap <silent> <leader>qo :15 copen <CR>
noremap <silent> <leader>qc :cclose <CR>

"noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><CR>
"noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><CR>
"noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><CR>
"noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
"noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
"noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
"noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
"noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

" use LeaderF
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/home/yult/.globalrc'
" should use `Leaderf gtags --update` first
"let g:Lf_GtagsGutentags = 1
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsAutoUpdate = 1
"let g:Lf_CacheDirectory = expand('~')
"let g:gutentags_cache_dir = expand(g:Lf_CacheDirectory.'/.LfCache/gtags')

let g:Lf_Gtagslabel = 'native-pygments'
"don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
 " popup mode
"let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
"let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fT :Leaderf gtags<CR>
"nmap <silent> <leader>ff :FzfFiles<CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cfile>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>



