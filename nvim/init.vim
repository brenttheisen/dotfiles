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
colorscheme NeoSolarized
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
let g:airline_solarized_bg='dark'
