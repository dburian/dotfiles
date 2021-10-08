-- Markdown nvim settings


vim.cmd[[
  syntax on

  syn region math start=/\$\$/ end=/\$\$/
  " inline math. Look for "$[not $][anything]$"
  syn match math_block '\$[^$].\{-}\$'

  "" Actually highlight those regions.
  hi link math String
  hi link math_block String
]]
