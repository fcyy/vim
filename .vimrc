" Enable syntax highlighting
syntax on

" Set line numbers
set number

" Map Esc
inoremap jj <Esc>
inoremap JJ <Esc>
inoremap Jj <Esc>

" Map j,k for wrapped text
nnoremap j gj
nnoremap k gk

" Wrap at word boundaries. Vim wraps lines by default.
set wrap
set linebreak

" Search options
set ignorecase
set smartcase

" Tab handling
set expandtab
set tabstop=3

" Set appearance (for vim GUIs)
colorscheme desert
set guifont=Monaco:h14
