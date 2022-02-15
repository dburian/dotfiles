local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local lua_snippets = {
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

return lua_snippets
