local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require 'luasnip.extras.fmt'.fmt

local problem_snippet = s({ trig = 'problem', dscr = "Create new problem." },
  fmt([[## problem: (problem_name)

- what: (problem_description)
- why: (problem_importance)

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
    thought_process = i(4, "<document thought process>"),
    implementation_solutions = i(5, "<implementation problems and solutions>")
  }, {
    delimiters = "()"
  }))

local snippets = {
  problem_snippet,
}

ls.add_snippets('tmpfile', snippets, { key = 'tmpfile' })
