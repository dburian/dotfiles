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


""" Recommended for syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ["eslint"]

""" Custom

let g:ctrlp_extensions = ['tag', 'changes']

""" Autocommands
"" Due to ivis
au BufReadPre *.js :set tabstop=4 shiftwidth=4


