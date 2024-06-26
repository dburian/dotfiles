-- Markdown nvim settings-- Markdown nvim settings-- Markdown nvim settings-- Markdown nvim settings
local nmap = require 'db.keymap'.nmap
vim.opt.textwidth = 80
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.formatoptions = vim.opt.formatoptions + 't' -- Autowrap on
vim.opt.commentstring = '<!---%s--->'
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 9

vim.cmd [[
  syntax on

  syn region math start=/\$\$/ end=/\$\$/
  " inline math. Look for "$[not $][anything]$"
  syn match math_block '\$[^$].\{-}\$'

  "" Actually highlight those regions.
  hi link math String
  hi link math_block String

]]

nmap({
    '<leader>gd',
    require 'telescope'.extensions['markdown-links'].find_links,
    { noremap = true, silent = true, buffer = 0 }
})
nmap({
    '<leader>gr',
    require 'telescope'.extensions['markdown-links'].find_backlinks,
    { noremap = true, silent = true, buffer = 0 }
})
