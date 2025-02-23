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

        func! MenuSelected(id, result)
           if a:result == 1
              :split $MYVIMRC
           elseif a:result == 2
              if s:ObsidianFound
                 execute 'lcd '.s:ObsidianICloudPath      
                 pwd
              endif
           else
              " Do nothin'
           endif
        endfunc

        let s:CdObsidianOption = s:ObsidianFound ? "Change dir to Obsidian" : "Obsidian iCloud not found." 
        call popup_menu(['Open vimrc', s:CdObsidianOption, 'Cancel'], #{
           \ callback: 'MenuSelected',
           \ title: 'Menu' 
           \ })
endfunc
nnoremap <leader>m :call ShowPopup()<CR>
