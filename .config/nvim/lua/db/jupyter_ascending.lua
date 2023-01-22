local nmap = require 'db.keymap'.nmap

local m = {}

local base_cmd = "python -m jupyter_ascending.requests"

local augroup_sync = vim.api.nvim_create_augroup(
  'jupyter_ascending_sync',
  { clear = true }
)
local augroup_attach = vim.api.nvim_create_augroup(
  "jupyter_ascending_attach",
  { clear = true }
)

function m.run_all()
  vim.cmd [[:write]]
  local filename = vim.fn.expand("%:p")

  local cmd = string.format(
    base_cmd .. ".execute_all --filename '%s'",
    filename
  )
  vim.fn.jobstart(cmd)
end

function m.run_cell()
  vim.cmd [[:write]]
  local filename = vim.fn.expand("%:p")

  local line_num = vim.fn.line(".")
  local cell_start_regex = vim.regex('^# %%')
  local match = cell_start_regex:match_line(0, line_num - 1)
  while match == nil do
    line_num = line_num - 1
    match = cell_start_regex:match_line(0, line_num)
  end

  local cmd = string.format(
    base_cmd .. ".execute --filename '%s' --linenumber '%s'",
    filename,
    line_num
  )
  vim.fn.jobstart(cmd)
end

function m.sync()
  local filename = vim.fn.expand("%:p")

  local cmd = string.format(
    base_cmd .. ".sync --filename %s",
    filename
  )

  vim.fn.jobstart(cmd)
end

function m.attach_to_notebook()
  print('jupyter_ascending: Attached to ' .. vim.fn.expand('%:p:t') .. '.')

  nmap({ '<leader>ra', m.run_all, { buffer = 0, noremap = 0 } })
  nmap({ '<leader>rc', m.run_cell, { buffer = 0, noremap = 0 } })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup_sync,
    buffer = 0,
    callback = m.sync
  })

end

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup_attach,
  pattern = "*.sync.py",
  callback = m.attach_to_notebook,
})

return m
