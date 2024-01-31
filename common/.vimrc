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
set tabstop     =4                " insert 2 spaces for a tab
set softtabstop =4                " insert 2 spaces for a tab
set shiftwidth  =4                " the number of spaces inserted for each indentation
set expandtab                     " convert tabs to spaces

" set <leader> to <space>
let mapleader = " "

" optimizing movements
nnoremap <silent> X 0d$jw
nnoremap <silent> <C-/> :vsplit<CR>:bnext<CR>

set noerrorbells
set vb t_vb=

" don't lose selection when indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" make Y behave like D and C, yanking till end of line
map Y y$

" closing quick fix window after selection
:autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" closing all buffer and reopening the last one
nnoremap <leader>we :%bd\|e#<CR>
