:so ~/.config/nvim/plug.vim

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

""" Line numbers
" set relativenumber


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


""" Mappings
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :CtrlP<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>
imap <F3> <Esc>:CtrlP<CR>

nmap <C-L> <C-W>l
nmap <C-K> <C-W>k
nmap <C-J> <C-W>j
nmap <C-H> <C-W>h

command -nargs=1 Rename execute "%s/" . expand("<cword>") . "/<args>/gc"

""" Custom
let g:ctrlp_extensions = ['tag', 'changes']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(\.git)|(node_modules)',
  \ 'file': '\vnode_modules/*',
  \ }

""" ALE
let g:ale_linters = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['eslint'] }
" let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['prettier', 'eslint'] }
" let g:ale_fixers.javascript = ['eslint']

let g:ale_open_list = 0
let g:ale_set_highlights = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 0

set signcolumn=yes

highlight SignColumn ctermbg=NONE
highlight Folded cterm=italic,bold ctermfg=247 ctermbg=NONE
highlight Todo cterm=italic,bold ctermfg=240 ctermbg=NONE
highlight Comment ctermfg=240
highlight Error cterm=bold ctermfg=124 ctermbg=NONE
highlight SpellBad ctermbg=52
highlight LineNr ctermfg=240
highlight CursorLineNr ctermfg=240

""" Autocommands
"" Due to ivis
au BufReadPre *.js :set tabstop=4 shiftwidth=4

""" For closing quickfix window
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

:so ~/.config/nvim/coc_settings.vim
