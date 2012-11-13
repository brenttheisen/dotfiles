syntax enable
colorscheme bclear

" Load Pathogen
call pathogen#infect()

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

" Profiles for dbext
let g:dbext_default_type   = 'MYSQL'
let g:dbext_default_user   = 'brent'
let g:dbext_default_passwd = ''

let g:dbext_default_profile_usual = 'type=MYSQL:user=brent:passwd=:dbname=womply_development:extra=-t'

" Vim-Ruby stuff
if has("autocmd")
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType ruby let g:rubycomplete_buffer_loading=1
    autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif
