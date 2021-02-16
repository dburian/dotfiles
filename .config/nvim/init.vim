:so ~/.config/nvim/plug.vim

:so ~/.config/nvim/start/mappings.vim
"TODO: 80 columns
"TODO: Abbreviations specific to buffer type

set wildmode=list:longest " Setup Tab completion to work like in a shell

""" Tab Completion
set wildmode=list:longest " Setup Tab completion to work like in a shell

""" Search
set ignorecase   " case-insensitive search
set smartcase    " but case-sensitive if expression contains a capital letter

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
set number          " display line numbers
set relativenumber  " number lines relative to current line
set signcolumn=yes  " display sings before numbers


""" Folds
" set foldmethod=indent

" For syntax folding...
set foldmethod=syntax
set foldlevelstart=0

""" Syntax on
syntax enable

""" For formatting lines
set textwidth=80

