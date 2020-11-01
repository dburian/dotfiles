" Argument is directory for plugins
call plug#begin('~/.vim/bundle')


" Intellisense engine
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax files
Plug 'https://github.com/sheerun/vim-polyglot'

" Fuzzy search
Plug 'https://github.com/ctrlpvim/ctrlp.vim'

" Linters
Plug 'dense-analysis/ale'

" File browsing
Plug 'https://github.com/scrooloose/nerdtree'

" Adding surround verb to vim
Plug 'https://github.com/tpope/vim-surround'

" Adding comment verb to vim
Plug 'https://github.com/tpope/vim-commentary'

" Adding indent noun to vim
Plug 'https://github.com/michaeljsmith/vim-indent-object'

" Adding replace-with-register verb to vim
Plug 'https://github.com/inkarkat/vim-ReplaceWithRegister'

" Better session management
Plug 'https://github.com/tpope/vim-obsession'

" Git
Plug 'https://github.com/tpope/vim-fugitive'

" Moving accross lines
Plug 'https://github.com/easymotion/vim-easymotion'


" Automatically executes:
"   filetype plugin indent on
"   syntax enable
call plug#end()
