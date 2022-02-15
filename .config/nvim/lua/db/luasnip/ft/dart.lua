-- Snippets for dart
--

local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local isn = ls.indent_snippet_node

local create_state_func = function(args)
  local class_name = args[1][1]
  return {
    '@override',
    'State<' .. class_name .. '> createState() => _' .. class_name .. 'State();'
  }
end

local state_name = function(args)
  return '_' .. args[1] ..'State'
end

local state_type = function (args)
  return 'State<' .. args[1][1] .. '>'
end

local dart_snippets = {
  s({
    trig = 'stateless',
    dscr = 'Stateless flutter widget',
  },
  {
    t('class '),
    i(1, 'WidgetName'),
    t({' extends StatelessWidget {', ''}),
    isn(0, {
      i(1, '  '),
      t({'', '@override', 'Widget build(BuildContext context) {', ''}),
      isn(0, {
        t({'//TODO: implement build', ''}),
        i(0, 'throw UnimplementedError();'),
      }, '$PARENT_INDENT  '),
      t({'', '}'}),
    }, '  '),
    t({'', '}'})
  }),
  s({
    trig = 'statefull',
    dscr = 'Statefull flutter widget',
  },
  {
    t('class '),
    i(3, 'WidgetName'),
    t({' extends StatefullWidget {', ''}),
    i(2, ''),
    t(''),
    f(create_state_func, {3}),
    t({'}', '}', ''}),

    t('class '), f(state_name, {3}), f(state_type, {3}), t('}'),
    i(1),
    t({'', '  @override', ' Widget build(BuildContext context) {', ''}),
    i(0, '    //TODO: implement build'),
    t({'', '}', '}'})
  })
}

return dart_snippets
