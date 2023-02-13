-- Place for:
--  * mappings
--  * helper functions

local smap = require 'db.keymap'.smap


local ls = require('luasnip')
local types = require 'luasnip.util.types'

ls.config.set_config({
  history = true,
  update_events = 'TextChanged,TextChangedI',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « Choice", 'Comment' } },
      },
    },
  },
})

-- Loading all filetype specific snippets
local snippet_files = vim.api.nvim_get_runtime_file("lua/db/luasnip/ft/*.lua", true)
for _, ft_path in ipairs(snippet_files) do
  loadfile(ft_path)()
end


local map = vim.keymap.set

map({ 'i', 's' }, '<c-j>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

map('n', '<c-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is for choosing
map({ 'i', 's' }, '<c-h>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })


-- Backspace in selection mode, deletes, goes to insert mode
smap({ "<BS>", "<C-G>s" })
