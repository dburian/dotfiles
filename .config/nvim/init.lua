-- My neovim configuration
--
--  - lua/db - lua files that export util functions
--  - after/plugin - configuration of plugins (possibly using lua/db/..)
--  - plugin/ - files that should be loaded automatically ASAP

if vim.fn.filereadable(vim.fn.expand('~/.config/nvim/colors/db.lua')) > 0 then
  vim.cmd [[colorscheme db]]
end

-- Leader
vim.g.mapleader = ','


-- Load plugins
require('db.plugins')

-- Globals
require('db.globals')
