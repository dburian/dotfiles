local ls = require'luasnip'

local s = ls.snippet
local i = ls.insert_node
local fmt = require'luasnip.extras.fmt'.fmt

local snippets = {
  s('todo',
    fmt('# TODO: {}', {i(0, 'I need to ...')})
  )
}

ls.add_snippets('python', snippets, { key = 'python' })
