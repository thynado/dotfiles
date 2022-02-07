call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

filetype on
filetype plugin on
filetype indent on
syntax on
set t_Co=256
colorscheme onehalfdark
hi Normal guibg=NONE ctermbg=NONE
let g:airline_theme='onehalfdark'
set backspace=indent,eol,start
set noswapfile
set cursorline
set expandtab
set history=1000
set hlsearch
set ignorecase
set incsearch
set nobackup
set nocompatible
set nowrap
set number
set scrolloff=10
set shiftwidth=4
set showcmd
set showmatch
set tabstop=4
set wildmenu
