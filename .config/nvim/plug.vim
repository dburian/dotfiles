" Argument is directory for plugins
call plug#begin('~/.local/share/nvim/bundle')

" Syntax files
Plug 'https://github.com/sheerun/vim-polyglot'

" Adding surround verb to vim
Plug 'https://github.com/tpope/vim-surround'

" Adding comment verb to vim
Plug 'https://github.com/tpope/vim-commentary'

" Adding indent noun to vim
Plug 'https://github.com/michaeljsmith/vim-indent-object'

" Adding replace-with-register verb to vim
Plug 'https://github.com/inkarkat/vim-ReplaceWithRegister'

" Git
Plug 'https://github.com/tpope/vim-fugitive'

" Moving accross lines
Plug 'https://github.com/easymotion/vim-easymotion'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"" Sorters
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'


" My stuff
Plug '~/Documents/Slip.nvim'

" Automatically executes:
"   filetype plugin indent on
"   syntax enable
call plug#end()
