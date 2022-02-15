
local ls = require('luasnip')

local lua_snippets = require('db.luasnip.ft.lua')
local dart_snippets = require('db.luasnip.ft.dart')

ls.snippets = {
  lua = lua_snippets,
  dart = dart_snippets,
}

vim.cmd [[
  inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'

  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<CR>
]]
