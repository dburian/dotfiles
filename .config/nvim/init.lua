-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- Globals
require('db.globals')

-- Define a leader
vim.g.mapleader = ','

-- Lsp configuration
config_require('db.lsp')

-- Plugin configuration
config_require('db.jupyter_integration')
config_require('db.express_line')
config_require('db.nvim-cmp')
config_require('db.telescope')
config_require('db.treesitter')
config_require('db.luasnip')

-- My plugins
config_require('db.slip')

