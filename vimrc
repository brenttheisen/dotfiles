syntax enable
colorscheme bclear

" Load Pathogen
call pathogen#infect()

" Load Vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails.git'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'L9'
Plugin 'wincent/Command-T'
Plugin 'derekwyatt/vim-scala'
Plugin 'gitignore'
Plugin 'elubow/cql-vim'
Plugin 'plasticboy/vim-markdown'

filetype plugin indent on     " required!

" A bunch of settings from http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/
set cf  " Enable error files & error jumping.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
" colorscheme vividchalk  " Uncomment this to set a default theme

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
set laststatus=2  " Always show status line.

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
autocmd BufRead * inoremap # X<c-h>#

set clipboard=unnamed

" Color for inactive window status line
hi StatusLineNC ctermbg=7 ctermfg=234

" Vim-Ruby stuff
if has("autocmd")
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType ruby let g:rubycomplete_buffer_loading=1
    autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

" Gist.vim
let g:gist_post_private = 1
let g:gist_get_multiplefile = 1

" Powerline
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/

set laststatus=2 " Always show statusline
set t_Co=256 " Use 256 colours

" Fugitive gutter color overrides
highlight SignColumn ctermbg=None

let mapleader = ","
set path=.,,,**

" For CQL plugin
autocmd BufRead *.cql set syntax=cql

" Fix for buffer delete syntax highlight loss in next window
set hidden

" Don't do folding for markdown plugin
let g:vim_markdown_folding_disabled=1

