-- My neovim configuration
--
--  - lua/db - lua files that export util functions
--  - after/plugin - configuration of plugins (possibly using lua/db/..)
--  - plugin/ - files that should be loaded automatically ASAP


-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- Globals
require('db.globals')
