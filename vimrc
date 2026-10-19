" ~/.vim/init.vim
" pack/nvim/start/nvim-lspconfig targets a newer Neovim than this one.
let g:lspconfig = 1

set nocompatible
call plug#begin('~/.vim/plugged')

" files, motion, git
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

" edit
Plug 'scrooloose/nerdcommenter'
Plug 'vim-autoformat/vim-autoformat'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'vim-scripts/DrawIt'

" markdown
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'SirVer/ultisnips', { 'for': 'markdown' }
Plug 'honza/vim-snippets'
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" language
Plug 'github/copilot.vim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'kyoz/purify', { 'rtp': 'vim' }

call plug#end()

let mapleader = ','

" Copilot accepts with <C-l>. Completion menu uses <Tab>.
let g:copilot_proxy = 'http://127.0.0.1:10808'
let g:copilot_node_command = expand('~/.node-v22.13.0-linux-x64/bin/node')
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" LeaderF is the only finder. gtags covers symbols when a language server is absent.
let $GTAGSCONF = expand('~/.globalrc')
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsAutoUpdate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = { 'Function': 1, 'BufTag': 0 }
let g:Lf_ShortcutF = '<leader>ff'

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

filetype plugin indent on
syntax on
colorscheme purify

set laststatus=2
set showtabline=2
set showcmd
set history=10000
set viminfo+=!
set updatetime=300
set scrolloff=2
set nobackup
set noswapfile
set noerrorbells
set novisualbell
set autoread
set autowrite
set number
set cursorline
set incsearch
set hlsearch
set nofoldenable
set mouse=
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set listchars=tab:>-,trail:■

nnoremap <F2> :set paste!<CR>

highlight CTagsGlobalVariable ctermfg=5 cterm=bold
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
highlight CursorLine cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE

function! CurDir() abort
  return substitute(getcwd(), $HOME, '~', 'g')
endfunction

set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}|

augroup user_config
  autocmd!
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | endif
augroup END

nmap cS :%s/\s\+$//g<CR>:noh<CR>
nmap cM :%s/\r$//g<CR>:noh<CR>
nmap <silent> <Leader>af :Autoformat<CR>:w<CR>
nmap fs <Plug>(easymotion-s)
nmap fj <Plug>(easymotion-j)
nmap fk <Plug>(easymotion-k)
nmap <silent> <leader>h :nohls<CR>

imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

nnoremap <silent> <leader>qo :15copen<CR>
nnoremap <silent> <leader>qc :cclose<CR>
nnoremap <silent> <leader>xx <cmd>lua vim.diagnostic.setqflist({open = true})<cr>
nnoremap <silent> <leader>xd <cmd>lua vim.diagnostic.setloclist({open = true})<cr>

nnoremap <leader>fb :<C-u>Leaderf buffer<CR>
nnoremap <leader>fm :<C-u>Leaderf mru<CR>
nnoremap <leader>ft :<C-u>Leaderf bufTag<CR>
nnoremap <leader>fl :<C-u>Leaderf line<CR>
nnoremap <leader>fT :<C-u>Leaderf gtags<CR>
nnoremap <C-b> :<C-u><C-r>=printf('Leaderf! rg --current-buffer -e %s ', expand('<cword>'))<CR>
nnoremap <C-f> :<C-u><C-r>=printf('Leaderf! rg -e %s', expand('<cfile>'))<CR>
xnoremap gf :<C-u><C-r>=printf('Leaderf! rg -F -e %s ', leaderf#Rg#visual())<CR>
nnoremap go :<C-u>Leaderf! rg --recall<CR>
nnoremap <leader>fr :<C-u><C-r>=printf('Leaderf! gtags -r %s --auto-jump', expand('<cword>'))<CR><CR>
nnoremap <leader>fd :<C-u><C-r>=printf('Leaderf! gtags -d %s --auto-jump', expand('<cword>'))<CR><CR>
nnoremap <leader>fo :<C-u>Leaderf! gtags --recall<CR>
nnoremap <leader>fn :<C-u>Leaderf gtags --next<CR>
nnoremap <leader>fp :<C-u>Leaderf gtags --previous<CR>

lua << EOF
do
  local caps = vim.lsp.protocol.make_client_capabilities()
  local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    caps = cmp_lsp.default_capabilities(caps)
  end

  local function root(markers)
    return function(fname)
      local found = vim.fs.find(markers, { path = fname, upward = true })[1]
      return found and vim.fs.dirname(found) or vim.fs.dirname(fname)
    end
  end

  local servers = {
    clangd = {
      cmd = { 'clangd' },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      root_dir = root({ 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' }),
    },
    gopls = {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = root({ 'go.work', 'go.mod', '.git' }),
    },
    rust_analyzer = {
      cmd = { 'rust-analyzer' },
      filetypes = { 'rust' },
      root_dir = root({ 'Cargo.toml', 'rust-project.json', '.git' }),
    },
    pyright = {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_dir = root({ 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' }),
    },
  }

  -- rustup ships a rust-analyzer proxy even when the component is missing.
  local ready_cache = {}
  local function server_ready(cmd)
    local bin = cmd[1]
    if ready_cache[bin] ~= nil then
      return ready_cache[bin]
    end
    local ready = vim.fn.executable(bin) == 1
    if ready and bin == 'rust-analyzer' then
      vim.fn.system({ bin, '--version' })
      ready = vim.v.shell_error == 0
    end
    ready_cache[bin] = ready
    return ready
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('user_lsp', { clear = true }),
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      for name, server in pairs(servers) do
        if vim.tbl_contains(server.filetypes, ft) and server_ready(server.cmd) then
          vim.lsp.start({
            name = name,
            cmd = server.cmd,
            root_dir = server.root_dir(vim.api.nvim_buf_get_name(args.buf)),
            capabilities = caps,
          })
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buf = args.buf
      local function map(lhs, rhs)
        vim.keymap.set('n', lhs, rhs, { buffer = buf, silent = true })
      end
      map('gd', vim.lsp.buf.definition)
      map('gr', vim.lsp.buf.references)
      map('K', vim.lsp.buf.hover)
      map('<leader>rn', vim.lsp.buf.rename)
      map('<leader>ca', vim.lsp.buf.code_action)
      map('[d', vim.diagnostic.goto_prev)
      map(']d', vim.diagnostic.goto_next)
    end,
  })

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-e>'] = cmp.mapping.abort(),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer' },
    },
  })
end

local ts_ok, ts = pcall(require, 'nvim-treesitter.configs')
if ts_ok then
  ts.setup({
    ensure_installed = { 'c', 'cpp', 'go', 'rust', 'python', 'lua', 'vim', 'markdown' },
    highlight = { enable = true },
    indent = { enable = true },
  })
end
EOF
