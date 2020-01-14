:so ~/.config/nvim/vundle.vim

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

""" Folds
set foldmethod=indent

""" Numbered lines
set number

""" Syntax on
syntax enable

""" For formatting lines
set textwidth=80


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
""" Custom

let g:ctrlp_extensions = ['tag', 'changes']
let g:livedown_browser = "qutebrowser"
let g:livedown_open    = 1
let g:livedown_port    = 1000

""" ALE
let g:ale_linters = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['eslint'] }

let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'], 'javascript': ['prettier', 'eslint'] }

let g:ale_fixers.javascript = ['eslint']

let g:ale_open_list = 0
let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 0
let g:ale_lint_on_text_changed = 'insert'

""" Autocommands
"" Due to ivis
au BufReadPre *.js :set tabstop=4 shiftwidth=4

""" For closing quickfix window
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

