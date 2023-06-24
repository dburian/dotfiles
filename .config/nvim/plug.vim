" Argument is directory for plugins
call plug#begin('~/.local/share/nvim/bundle')
"TODO: rewrite this in lua, maybe switch to packer?

" Verbs
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/inkarkat/vim-ReplaceWithRegister'
Plug 'https://github.com/easymotion/vim-easymotion'

" Repeat whole plugin maps
Plug 'tpope/vim-repeat'

" Objects/nouns
Plug 'https://github.com/michaeljsmith/vim-indent-object'

" Git
Plug 'https://github.com/tpope/vim-fugitive'

" Project drawer
Plug 'tpope/vim-vinegar'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'dburian/telescope-markdown-links'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context' " display context in first line

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'dburian/cmp-markdown-link'

Plug 'onsails/lspkind-nvim' " nice icons in autocomplete menu

" Snippets
Plug 'L3MON4D3/LuaSnip'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" My stuff
Plug '~/docs/cmp-markdown-link'

" Automatically executes:
"   filetype plugin indent on
"   syntax enable
call plug#end()
