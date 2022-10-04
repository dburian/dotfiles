local ls = require 'luasnip'
local utils = require 'db.luasnip.utils'

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local ins = ls.indent_snippet_node

local fmt = require 'luasnip.extras.fmt'.fmt

local snippets = {
  s({ trig = 'project', dscr = 'Initialize .tmux file for new project.' },
    {
      t({
        '#!/bin/sh',
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
      t({
        '',
        '',
      }),
      i(3, '# initialize tmux windows'),
      t({ '', '' }),
      t('tmux attach -t '), f(utils.same, { 1 }),
      t(':'), f(utils.same, { 2 }),
      t({ '' }),
    }
  ),
}

ls.add_snippets('dot_tmux', snippets, { key = 'dot_tmux' })
