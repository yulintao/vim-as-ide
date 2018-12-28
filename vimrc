"execute pathogen#infect()
call plug#begin('~/.vim/plugged')

" Keep Plugin commands between vundle#begin/end.
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
Plug 'Chiel92/vim-autoformat'
" commenter 
Plug 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call plug#end()            " required


function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
highlight CTagsGlobalVariable ctermfg=5 cterm=bold
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}|

" auto format
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
au BufWrite * :Autoformat

"autocmd  BufReadPost,FileReadPost   *.[ch]  :silent %!indent -l0 -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1

highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
set cul
"set cuc
"set nocompatible              " be iMproved, required
set incsearch
set hlsearch
set laststatus=2
"set tw=78 fo+=Mm
"set tabstop=2
set shiftwidth=4
"set expandtab
set history=1000
set cindent
"set autoindent
"set smartindent
set showtabline=2
" 回车换行，参数自动对齐到括号
set cino+=(0,w1,{0,0},:0,t0,+10
set autoread
set nu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set tags+=./TAGS

let mapleader=","
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:fzf_command_prefix = 'Fzf'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
"" auto format
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0


"let Tlist_Auto_Open = 1
let Tlist_Ctags_Cmd="/home/`whoami`/code/universal-ctags/ctags-work/bin/ctags-local"
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

syntax on
"set autochdir
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

"if executable('/home/yult/cquery/work-cquery/bin/cquery')
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
nmap fs <Plug>(easymotion-s)
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
