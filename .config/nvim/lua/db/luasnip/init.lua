
local ls = require('luasnip')

ls.config.set_config({
  history = true,
  update_events = 'TextChanged,TextChangedI',
})

-- TODO: Make it so i can resource snippets (or better even files) on the go.

ls.snippets = {
  lua = require'db.luasnip.ft.lua',
  dart = require'db.luasnip.ft.dart',
  python = require'db.luasnip.ft.python',
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
