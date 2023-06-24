local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local fmt = require'luasnip.extras.fmt'.fmt

local function same(args, _, node_ind)
  return args[node_ind][1]
end


local latex_snippets = {
  s(
    {
      trig = 'environment',
      dscr = 'begin an environment'
    },
    {
      t('\\begin{'),
      i(1, 'environment'),
      t({'}', ''}),
      i(0),
      t({'', ''}),
      t('\\end{'),
      -- t('environment'),
      f(same, {1}, {user_args = {1}}),
      t({'}', ''}),
    }
  )
}

ls.add_snippets('tex', latex_snippets, { key = 'tex'})
