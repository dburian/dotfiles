local ls = require 'luasnip'
local utils = require 'db.luasnip.utils'

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local ins = ls.indent_snippet_node

local fmt = require 'luasnip.extras.fmt'.fmt

local function tmpfile_creation(args)
  local sess_name = args[1][1]

  return sn(nil, {
    i(1),
    t({
      'tmux new-window -n ' .. sess_name .. ' -n tmpfile',
      'tmux send-keys -t ' .. sess_name .. ':tmpfile "v tmpfile.md Enter"',
      '',
    }),
  })
end

local snippets = {
  s({ trig = 'project', dscr = 'Initialize .tmux file for new project.' },
    {
      t({
        '#!/bin/sh',
        '',
        '',
      }),
      t('if tmux has-session "'), i(1, 'session_name'),
      t({ '" 2>/dev/null; then', '' }),
      t('  tmux attach -t "'), f(utils.same, { 1 }),
      t({
        '"',
        '  exit',
        'fi',
        '',
        '',
      }),
      t('tmux new-session -d -s "'), f(utils.same, { 1 }),
      t('" -n "'), i(2, 'default_window_name'),
      t('" -x $(tput cols) -y $(tput lines)'),
      t({ '', '', '', }),
      i(3, '# initialize tmux windows'),
      t({ '', '' }),
      c(4, {
        t({ '# No tmpfile for this project.', '' }),
        d(nil, tmpfile_creation, { 1 })
      }),
      t({ '', 'tmux attach -t ' }), f(utils.same, { 1 }),
      t(':'), f(utils.same, { 2 }),
      t({ '' }),
    }
  ),
}

ls.add_snippets('dot_tmux', snippets, { key = 'dot_tmux' })
