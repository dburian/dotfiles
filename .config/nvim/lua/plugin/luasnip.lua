
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
  lua = {
    s({
        trig = 'req',
        namr = 'require',
        dscr = "local <variable> = require('<package>')",
      }, {
        t('local '),
        i(1),
        t(' = require(\''),
        i(0),
        t('\')')
      }),
  }
}

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>

  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]
