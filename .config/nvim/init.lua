-- Plugins
vim.cmd('source ~/.config/nvim/plug.vim')

-- My files
require('mappings')


-- Settings
local o = vim.o   --global options
local wo = vim.wo --window local options
local bo = vim.bo --buffer local options

--- Tab completion
o.wildmode = 'list:lastused' --on Tab complete with the last buffer used

--- Search

o.ignorecase = true  --case-insensitive search
o.smartcase = true   --but case-sensitive if expression contains a capital letter

--- Buffers
o.hidden = true      --can abandoned buffers are not unloaded but hidden

--- Editor
o.scrolloff = 3  --show 3 lines of context around cursor
wo.list = true   --show invisible characters

bo.expandtab = true   --use spaces instead of tabs
bo.tabstop = 2        --global tab width
bo.shiftwidth = 2     --spaces to use when indenting
o.shiftround = true   --round to multiples of shiftwidth with '>' and '<'

bo.formatoptions = 'tcqj' --autoformatting options see :help fo-table

wo.number = true          --display line numbers
wo.relativenumber = true  --number lines relative to current line

vim.cmd('syntax enable')  -- enable syntax highlighting

--- Colors
vim.g.base16colorspace = 256
vim.cmd('source ~/.config/nvim/theme.vim')

--TODO: autocompletion
