-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- Globals
require('globals')

-- Lsp server config
config_require('lsp.lua')
config_require('lsp.python')
config_require('lsp.java')
config_require('lsp.dart')

-- My files
config_require('mappings')

-- Plugin configuration
config_require('plugin.telescope')
config_require('plugin.treesitter')
config_require('plugin.slip')
config_require('plugin.nvim-cmp')
config_require('plugin.luasnip')

-- TODO: temporary, think off a better setup
config_require('jupyter_integration')

-- Settings
local opt = vim.opt

-- Messages
opt.shortmess:remove('A')
--- Tab completion
opt.wildmode = 'list:full' --on Tab complete with the last buffer used

--- Search
opt.ignorecase = true  --case-insensitive search
opt.smartcase = true   --but case-sensitive if expression contains a capital letter

--- Buffers
opt.hidden = true      --can abandoned buffers are not unloaded but hidden

--- Editor
opt.scrolloff = 3  --show 3 lines of context around cursor
opt.list = true   --show invisible characters

opt.expandtab = true   --use spaces instead of tabs
opt.tabstop = 2        --global tab width
opt.shiftwidth = 2     --spaces to use when indenting
opt.shiftround = true   --round to multiples of shiftwidth with '>' and '<'

opt.textwidth = 80
opt.formatoptions = 'tcqj' --autoformatting options see :help fo-table

opt.number = true          --display line numbers
opt.relativenumber = true  --number lines relative to current line

opt.mouse = 'nv' --enable mouse for normal and visual mode
opt.timeoutlen = 500 --timeout for key sequences

opt.clipboard:append('unnamedplus')

vim.cmd[[syntax on]]

-- Configure pythons for remote plugins
--- Colors
vim.g.base16colorspace = 256
vim.cmd('source ~/.config/nvim/theme.vim')
