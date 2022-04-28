local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require'luasnip.extras.fmt'.fmt

local function extract_last_import_name(args)
  local parts = vim.split(args[1][1], '.', {plain = true})
  return parts[#parts] or ''
end

local lua_snippets = {
  s(
    {
      trig = 'req',
      dscr = 'require a packageeee'
    },
    fmt('local {} = require\'{}\'', {
      f(extract_last_import_name, {1}),
      i(1, 'package'),
    })
  ),

  s(
    {
      trig = 'todo',
      namr = 'TODO',
    },
    fmt('-- TODO: {}', {i(0, 'I need to ...')})
  ),
}

return lua_snippets
