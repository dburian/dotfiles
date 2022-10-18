-- Markdown nvim settings-- Markdown nvim settings-- Markdown nvim settings-- Markdown nvim settings
local nmap = require 'db.keymap'.nmap
vim.opt.textwidth = 80

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
