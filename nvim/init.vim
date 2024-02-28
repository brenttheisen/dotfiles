" init.vim or init.lua

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'overcache/NeoSolarized' 
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvimtools/none-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'
Plug 'github/copilot.vim'
call plug#end()

" Configuration
set termguicolors
syntax enable

" TypeScript and Next.js specific settings
" autocmd FileType typescriptreact setlocal ts=tsx
" autocmd FileType typescript setlocal ts=tsx

" Coc.nvim settings (for auto-completion, linting, etc.)
autocmd FileType javascript,c,javascriptreact,cpp setlocal equalprg=coc\#format\#sync\(\)
autocmd FileType typescript,json,javascriptreact,javascript setl formatprg=coc\#format\#sync\(\)

" Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-eslint',
  \ 'coc-prettier'
  \ ]

" Airline
" set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set background=dark
colorscheme NeoSolarized

" Copy to OS clipboard
set clipboard+=unnamedplus

" Line number gutter
set number

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set nocindent
" Attempt to not reindent comments (#)
" set cinkeys 0{,0},0),:,!^F,o,0,e
set autoindent
set smarttab
set expandtab

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" TODO Fix Trouble or remove it
" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Buffers
map gn :bnext<cr>
map gp :bprevious<cr>
map gd :bdelete<cr>

map <leader>\ :bnext<cr>
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>d :bdelete<cr>
