-- Settings
local opt = vim.opt

-- Messages
opt.shortmess:remove('A')
--- Tab completion
opt.wildmode = 'list:longest' --on Tab complete to longest matching substring and list all items

--- Search
opt.ignorecase = true --case-insensitive search
opt.smartcase = true --but case-sensitive if expression contains a capital letter

--- Buffers
opt.hidden = true --can abandoned buffers are not unloaded but hidden

--- Editor
opt.scrolloff = 3 --show 3 lines of context around cursor
opt.list = true --show invisible characters

opt.expandtab = true --use spaces instead of tabs
opt.tabstop = 2 --global tab width
opt.shiftwidth = 2 --spaces to use when indenting
opt.shiftround = true --round to multiples of shiftwidth with '>' and '<'

opt.textwidth = 0
opt.colorcolumn = '80' --paints 80th column w/ different color
opt.formatoptions = 'tcqj' --autoformatting options see :help fo-table

opt.number = true --display line numbers
opt.relativenumber = true --number lines relative to current line

opt.mouse = 'nv' --enable mouse for normal and visual mode
opt.timeoutlen = 500 --timeout for key sequences

opt.laststatus = 3 -- have only global status line for all splits
opt.foldmethod = 'marker' -- only marked folds

opt.listchars = {
  trail = '·',
  nbsp = '␣',
  tab = '» ',
  extends = '<',
  precedes = '>',
  conceal = '┊',
}


opt.clipboard:append('unnamedplus')

vim.cmd [[syntax on]]

vim.g.tex_flavor = 'latex' --setting tex flavour for LS

-- Configure pythons for remote plugins
--- Colors
vim.g.base16colorspace = 256
vim.cmd [[
  source ~/.config/nvim/theme.vim
  highlight WinSeparator guibg=None
]]
