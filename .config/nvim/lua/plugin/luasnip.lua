
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
