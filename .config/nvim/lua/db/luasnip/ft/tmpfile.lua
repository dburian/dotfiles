local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require 'luasnip.extras.fmt'.fmt

local problem_snippet = s({ trig = 'problem', dscr = "Create new problem." },
  fmt([[## problem: (problem_name)

- what: (problem_description)
- why: (problem_importance)
- timespan: (timespan)

<!---{{{1--->
### solution

(thought_process)

### implementation

(implementation_solutions)

<!---1}}}--->
]] , {
    problem_name = i(1, "<concise name>"),
    problem_description = i(2, "<description>"),
    problem_importance = i(3, "<why I need to solve it>"),
    timespan = i(4, "<time required>"),
    thought_process = i(5, "<document thought process>"),
    implementation_solutions = i(6, "<implementation problems and solutions>")
  }, {
    delimiters = "()"
  }))

local snippets = {
  problem_snippet,
}

ls.add_snippets('tmpfile', snippets, { key = 'tmpfile' })
