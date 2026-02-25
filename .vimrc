71
 18 " Install plugins using the vim-plug plugin manager
 17 " run :PlugInstall to install
 16 " run :PlugStatus to view status
 15 call plug#begin('~/.vim/plugged')
 14
 13 Plug 'preservim/vim-markdown'
 12 Plug 'morhetz/gruvbox'
 11 Plug 'junegunn/goyo.vim'
 10 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  9 Plug 'junegunn/fzf.vim'
  8
  7 call plug#end()
  6
  5 " Enable syntax highlighting
  4 syntax on
  3
  2 " Set line numbers and relative numbers
  1 set number
19  set relativenumber
  1
  2 " Set hot key for fzf
  3 nnoremap <Leader>f :Files<CR>
  4
  5 " Map Esc
  6 inoremap jj <Esc>
  7 inoremap JJ <Esc>
  8 inoremap Jj <Esc>
  9
 10 " Map j,k for wrapped text
 11 nnoremap j gj
 12 nnoremap k gk
 13
 14 " Wrap at word boundaries. Vim wraps lines by default.
 15 set wrap
 16 set linebreak
 17 set breakindent               " Indent wrapped lines by the same amount as the first line, but...
 18 set breakindentopt=shift:4    " ... add a further (shift:N) spaces to create a hanging indent.
 19
 20 " Search options
 21 set ignorecase
 22 set smartcase
 23
 24 " Tab handling
 25 set expandtab
 26 set tabstop=3
 27 set shiftwidth=0 " use the value of tabstop for > and <
 28
 29 " Set appearance (for vim GUIs)
 30 colorscheme gruvbox
 31 set background=dark
 32 " Source Code Pro is available on iOS (iVim), macOS. Should (?) also be available on Windows and Linux.
 33 if has('osx')
 34    set guifont=Source\ Code\ Pro:h16 " Install as needed with brew install --cask font-source-code-pro
 35    set linespace=5
 36 elseif has('ivim')
 37    set guifont=Source\ Code\ Pro:h18:b:i
 38 elseif has('windows')
 39    set guifont=Source\ Code\ Pro:h12
 40 endif
 41
 42 " Stop vim from changing long lines to @. Adds instead @@@@ to bottom right
 43 set display+=lastline
 44
 45 " Stop vim from trying to scroll prematurely
 46 " in an attempt to leave N lines visible when
 47 " cursor near top or bottom edge.
 48 set scrolloff=0
 49 set conceallevel=2
 50 let g:markdown_conceal = 1
 51 let g:vim_markdown_conceal_code_blocks = 1
 52 let g:vim_markdown_conceal = 2
 53
