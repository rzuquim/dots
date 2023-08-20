" Movimentation
:set number relativenumber

" Search
set hlsearch                      " highlight search occurrences
set ignorecase                    " ignore case in search patterns
set smartcase                     " no ignore case when pattern is uppercase
set incsearch                     " show search results while typing
set wrapscan                      " searches wrap around the end of the file
nnoremap <silent> <Esc> :noh<CR>

" Plugins
filetype plugin indent on

" Identation
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab

" set <leader> to <space>
let mapleader = " "

" optimizing movements
nnoremap <silent> l f.
nnoremap <silent> h F.
nnoremap <silent> X 0d$jw

set noerrorbells
set vb t_vb=

" don't lose selection when indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" make Y behave like D and C, yanking till end of line
map Y y$
