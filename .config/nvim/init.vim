:so ~/.config/nvim/plug.vim

:so ~/.config/nvim/startup/mappings.vim
"80 columns
"Abbreviations specific to buffer type

set wildmode=list:longest " Setup Tab completion to work like in a shell

""" Tab Completion
set wildmode=list:longest " Setup Tab completion to work like in a shell

""" Search
set ignorecase   " case-insensitive search
set smartcase
" but case-sensitive if expression contains a capital letter

""" Buffers
set hidden       " Handle multiple buffers better
" You can abandon a buffer with unsaved changes without a warning

""" Terminal
set title        " show terminal title

""" Editor
set scrolloff=3  " show 3 lines of context around cursor
set list         " show invisible characters

""" Global Tabs and Spaces configurations
set expandtab    " use spaces instead of tabs
set tabstop=2    " global tab width
set shiftwidth=2 " spaces to use when indenting
set shiftround   " round to shiftwidth multiple

""" Line numbers
set relativenumber


""" Folds
" set foldmethod=indent

" For syntax folding...

set foldmethod=syntax
set foldlevelstart=0
let javaScript_fold=1
let vimsyn_folding='af'
let xml_syntax_folding=1

""" Numbered lines
set number

""" Syntax on
syntax enable

""" For formatting lines
set textwidth=80

""" Tags
set tags+=./.git/tags
set cpoptions+=d

""" Compile latex files
command TexCompile write | !pdflatex %:t; biber %:t:r; pdflatex %:t
command TexUpdate write | !pdflatex %:t
command TexView !zathura --fork %:p:r.pdf


command -nargs=1 Rename execute "%s/" . expand("<cword>") . "/<args>/gc"

""" Custom
let g:ctrlp_extensions = ['undo', 'changes']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(\.git)|(node_modules)',
  \ 'file': '\vnode_modules/*',
  \ }

let NERDTreeShowHidden=1

""" ALE
let g:ale_linters = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['eslint'] }
let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['prettier', 'eslint'] }

let g:ale_open_list = 0
let g:ale_set_highlights = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_hover_to_preview = 0
let g:ale_virtualtext_cursor = 1

set signcolumn=yes

highlight SignColumn ctermbg=NONE
highlight Folded cterm=italic,bold ctermfg=250 ctermbg=NONE
highlight Todo cterm=italic,bold ctermfg=244 ctermbg=NONE
highlight Comment ctermfg=244
highlight Error cterm=bold ctermfg=9 ctermbg=NONE
highlight SpellBad ctermbg=NONE ctermfg=9 cterm=underline
highlight link ALEVirtualTextError Error
highlight link ALEVirtualTextWarning Error
highlight link ALEWarning Error
highlight LineNr ctermfg=244
highlight CursorLineNr ctermfg=244
highlight MatchParen ctermbg=250

""" Autocommands
"" Due to ivis
augroup ivis
  autocmd!
  autocmd BufReadPre *.js :set tabstop=4 shiftwidth=4
augroup END

""" For closing quickfix window
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

:so ~/.config/nvim/coc_init.vim
