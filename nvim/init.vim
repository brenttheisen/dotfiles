" init.vim or init.lua

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'edkolev/tmuxline.vim'
Plug 'overcache/NeoSolarized' 
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

" Configuration
set termguicolors
syntax enable

" TypeScript and Next.js specific settings
autocmd FileType typescriptreact setlocal ts=tsx
autocmd FileType typescript setlocal ts=tsx

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
set background=dark
colorscheme NeoSolarized

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

