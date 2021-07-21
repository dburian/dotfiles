-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- Lsp server config
require('lsp.lua')

-- My files
require('mappings')

-- Plugin configuration
require('plugin.telescope')
require('plugin.slip')
require('plugin.nvim-compe')
require('plugin.luasnip')

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

vim.cmd('syntax enable')  -- enable syntax highlighting

--- Colors
vim.g.base16colorspace = 256
vim.cmd('source ~/.config/nvim/theme.vim')
vim.g.colors_name = nil
