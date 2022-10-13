local ls = require 'luasnip'

local s = ls.snippet
local sn = ls.snippet_node
local c = ls.choice_node
local i = ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

local def_str = [[def {}({}) -> {}:
    {}]]

local for_str = [[for {} in {}:
    {}]]

local if_main_str = [[if __name__ == '__main__':
    {}
]]
local snippets = {
  s('todo',
    fmt('# TODO: {}', { i(0, 'I need to ...') })
  ),
  s({ trig = 'def', dscr = 'Define function.' }, fmt(def_str, {
    i(1, 'func_name'),
    i(2, 'params'),
    i(3, 'ReturnType'),
    i(4, 'pass'),
  })),
  s({ trig = 'for', dscr = 'A for loop.' }, fmt(for_str, {
    i(1, 'var'),
    c(2, {
      sn(nil, fmt('range({})', i(1, 'max_iters'))),
      i(1, 'iterable'),
      sn(nil, fmt('enumerate({})', i(1, 'iterable'))),
    }),
    i(3, 'pass'),
  })),
  s({ tring = 'main', dscr = 'Main section' }, fmt(if_main_str, {
    i(1, 'pass'),
  })),
}

ls.add_snippets('python', snippets, { key = 'python' })
