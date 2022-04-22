
local ls = require('luasnip')

local lua_snippets = require('db.luasnip.ft.lua')
local dart_snippets = require('db.luasnip.ft.dart')

ls.config.set_config {
  history = true,
  update_events = 'TextChanged, TextChangedI',
}



ls.snippets = {
  lua = lua_snippets,
  dart = dart_snippets,
}

local map = vim.keymap.set

map({'i', 's'}, '<c-j>', function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

map('n', '<c-k>', function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})

map("i", "<c-h>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, {silent = true})


-- vim.cmd [[
--   inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
--   imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'

--   snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
--   snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<CR>
-- ]]
