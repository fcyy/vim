" Install plugins using the vim-plug plugin manager
" run :PlugInstall to install
" run :PlugStatus to view status
call plug#begin('~/.vim/plugged')

Plug 'preservim/vim-markdown'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim' 

call plug#end()

" Enable syntax highlighting
syntax on

" Set line numbers and relative numbers
set number
set relativenumber

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
set breakindent               " Indent wrapped lines by the same amount as the first line, but...
set breakindentopt=shift:4    " ... add a further (shift:N) spaces to create a hanging indent.

" Search options
set ignorecase
set smartcase

" Tab handling
set expandtab
set tabstop=3

" Set appearance (for vim GUIs)
colorscheme gruvbox
set background=dark
" Source Code Pro is available on iOS (iVim), macOS. Should (?) also be available on Windows and Linux.
if has('osx')
   set guifont=Source\ Code\ Pro:h16 " Install as needed with brew install --cask font-source-code-pro
   set linespace=5
elseif has('ivim')
   set guifont=Source\ Code\ Pro:h18:b:i 
elseif has('windows')
   set guifont=Source\ Code\ Pro:h12
endif

" Stop vim from changing long lines to @. Adds instead @@@@ to bottom right
set display+=lastline

" Stop vim from trying to scroll prematurely
" in an attempt to leave N lines visible when
" cursor near top or bottom edge.
set scrolloff=0
set conceallevel=2
let g:markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_conceal = 2

let g:goyo_width = 60
let g:goyo_height = 999

" Popup menu
function! ShowPopup()
        let s:ObsidianICloudPath = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-fy'
        let s:ObsidianICloudPath = expand(s:ObsidianICloudPath)
        let s:ObsidianFound = 0
        if isdirectory(s:ObsidianICloudPath) 
           let s:ObsidianFound = 1
        else
           " We could be on an iPad. Try to find it.
           let s:ObsidianICloudPath = '/private/var/mobile/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-fy'
           if isdirectory(s:ObsidianICloudPath) 
              let s:ObsidianFound = 1
           endif
        endif

        " Build menu 
        let MenuOptions = []
        let s:OpenVimrcOption = 'Open vimrc'
        let s:CdObsidianOption = s:ObsidianFound ? "Change dir to Obsidian" : "Obsidian iCloud not found." 
        let s:CountMdH1WordsOption = 'Count markdown H1 words'
        let s:CancelOption = 'Cancel'
        call add(MenuOptions, s:OpenVimrcOption)
        call add(MenuOptions, s:CdObsidianOption)
        if &filetype == 'markdown'
           call add(MenuOptions, s:CountMdH1WordsOption)
        endif
        call add(MenuOptions, s:CancelOption)

        func! MenuSelected(id, result) closure
           if MenuOptions[a:result-1] == s:OpenVimrcOption
              :split $MYVIMRC
           elseif MenuOptions[a:result-1] == s:CdObsidianOption 
              if s:ObsidianFound
                 execute 'lcd '.s:ObsidianICloudPath      
                 pwd
              endif
           elseif MenuOptions[a:result-1] == s:CountMdH1WordsOption 
              call WordCountBetweenHeadings()
           else
              " Do nothin'
           endif
        endfunc

        call popup_menu(MenuOptions, #{
           \ callback: 'MenuSelected',
           \ title: 'Menu' 
           \ })
endfunc
nnoremap <leader>m :call ShowPopup()<CR>

function! WordCountBetweenHeadings()
    " Save the cursor position
    let orig_pos = getpos(".")

    " Move to the first level 1 heading (backward search)
    silent! execute "normal! ?^# \<CR>"

    " Enter Visual Line Mode
    silent! execute "normal! V\<CR>"

    " Move to the second level 1 heading (forward search)
    " and offset the cursor by one line, to exclude the 
    " 2nd heading.
    silent! execute "normal! /^# /-1\<CR>"

    " If no second level 1 heading found, set the end to the end of the file
    if getpos(".")[1] == 1
        normal! G
    endif

    " Perform word count using g Ctrl-G and capture the result
    redir => word_count_output
    silent execute "normal! g\<C-G>"
    redir END

    " Display the result
    echo word_count_output

    " Go back to normal mode
    silent execute "normal! V"

    " Restore the cursor position
    call setpos(".", orig_pos)
endfunction

" Map the function to a key, e.g., <Leader>w
nnoremap <Leader>w :call WordCountBetweenHeadings()<CR>
