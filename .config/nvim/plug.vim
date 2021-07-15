" Argument is directory for plugins
call plug#begin('~/.local/share/nvim/bundle')

" Syntax files
Plug 'https://github.com/sheerun/vim-polyglot'

" Verbs
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/inkarkat/vim-ReplaceWithRegister'
Plug 'https://github.com/easymotion/vim-easymotion'

" Objects/nouns
Plug 'https://github.com/michaeljsmith/vim-indent-object'

" Git
Plug 'https://github.com/tpope/vim-fugitive'


" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-compe'

" Snippets
Plug 'L3MON4D3/LuaSnip'


" My stuff
Plug '~/Documents/Slip.nvim'

" Automatically executes:
"   filetype plugin indent on
"   syntax enable
call plug#end()
