local ls = require 'luasnip'
local utils = require 'db.luasnip'

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local fmt = require 'luasnip.extras.fmt'.fmt

local new_sess_patts = {
  'tmux new%-session [-_%w ]*%-s ?"([^"]+)"',
  'tmux new%-session [-_%w ]*%-s ?([^ "]+)',
}

local window_patts = {
  'tmux [-_%w "]*%-n ?"([^"]+)"',
  'tmux [-_%w "]*%-n ?([^ "]+)',
}

local all_windows_str = [[for win in `tmux list-windows -F \#W -t "{}"`; do
  {}
done
]]

local function match_patts(str, patts, return_all)
  local matches = {}
  for _, patt in ipairs(patts) do
    local match = string.match(str, patt)
    if match ~= nil then
      table.insert(matches, match)
      if not return_all then
        return matches[1]
      end
    end
  end

  if return_all then
    return matches
  else
    return nil
  end
end

local function select_session()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local default_sess_name = nil
  for _, line in ipairs(lines) do
    default_sess_name = match_patts(line, new_sess_patts)
    if default_sess_name ~= nil then
      break
    end
  end
  local new_session_node = i(1, 'session_name')

  if default_sess_name then
    return sn(nil, {
      c(1, {
        t(default_sess_name),
        new_session_node,
      })
    })
  else
    return sn(nil, { new_session_node })
  end
end

local function select_window()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local window_names = {}
  for _, line in ipairs(lines) do
    table.insert(window_names, match_patts(line, window_patts, true))
  end
  window_names = vim.tbl_flatten(window_names)

  local choice_nodes = vim.tbl_map(function(win_name)
    return t(win_name)
  end, window_names)
  table.insert(choice_nodes, t('$win'))
  table.insert(choice_nodes, i(1, 'window_name'))

  if #choice_nodes == 1 then
    return sn(nil, choice_nodes)
  end

  return sn(nil, {
    c(1, choice_nodes)
  })
end

local snippets = {
  s({ trig = 'project', dscr = 'Initialize .tmux file for new project.' },
    fmt(
      [[#!/bin/sh

if tmux has-session -t ="{input_sess}" 2>/dev/null; then
  tmux attach -t "{sess}"
  exit
fi

tmux new-session -d -s "{sess}" -n "{input_def_win}" -x $(tput cols) -y $(tput lines)

{window_setup}

tmux attach -t "{sess}":"{def_win}"
]]     , {
      input_sess = i(1, 'session_name'),
      sess = f(utils.same, { 1 }),
      input_def_win = i(2, 'default_window_name'),
      window_setup = i(3, '# window setup'),
      def_win = f(utils.same, { 2 })
    })
  ),
  s({ trig = 'tmp file', dsrc = 'Create temp file in new window.' },
    fmt([[# tmpfile.md initialization
tmux new-window -n "{}" -n tmpfile
tmux send-keys -t "{}":tmpfile "v tmpfile.md" Enter
      ]], {
      d(1, select_session, {}),
      f(utils.same, { 1 }),
    })
  ),
  s({ trig = 'new-window', dscr = 'Create new tmux window.' },
    fmt('tmux new-window -t "{}" -n "{}"', {
      d(1, select_session, {}),
      i(2, 'window_name')
    })
  ),
  s({ trig = 'send-keys', dscr = 'Send keys to tmux window' },
    fmt('tmux send-keys -t "{}":"{}" "{}"', {
      d(1, select_session, {}),
      d(2, select_window, {}),
      i(3, 'keys to send'),
    })
  ),
  s({ trig = 'all-windows', dscr = 'Do cmd for all windows' },
    fmt(all_windows_str, {
      d(1, select_session, {}),
      i(2, '# do something here'),
    })
  ),
}

ls.add_snippets('dot_tmux', snippets, { key = 'dot_tmux' })
