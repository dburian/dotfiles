-- My neovim configuration
--
-- - lua/db - my configuration of plugins
-- - plugin/ - my other files configuring core nvim
--
-- Slowly tranistion to:
--
--  - lua/db - lua files that export the functionality
--  - after/plugin - configuration of plugins (possibly using lua/db/..)
--  - plugin/ - files that should be loaded automatically ASAP


-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- Globals
require('db.globals')

-- Define a leader
vim.g.mapleader = ','

-- Lsp configuration
config_require('db.lsp.init')

-- Plugin configuration
config_require('db.jupyter_ascending')
config_require('db.express_line')
config_require('db.nvim-cmp')
config_require('db.telescope')
config_require('db.treesitter')
config_require('db.luasnip')

-- My plugins
config_require('db.slip')
