-- Configuration and mappings of Jupyter qt console integration

-- regex for start and end of cell
vim.g.ipy_celldef = '# %%'
-- do not apply ipy default mappings
vim.g.nvim_ipy_perform_mappings = 0

-- convert ipynb files to hydrogen-python format
vim.g.jupytext_fmt = 'py:percent'

local m = {}

function m.start_qtconsole(used_kernel)
  -- Starts up jupyter qtconsole accepting remote input with specified kernel
   vim.fn.jobstart('jupyter qtconsole --kernel ' .. used_kernel .. ' --ConsoleWidget.include_other_output "True"')
end

function m.connect_to_qtconsole()
  -- Connects throu nvim-ipy to jupyter kernel ran as last
  vim.fn.IPyConnect('--existing', '--no-window')

  local buf_map = vim.api.nvim_buf_set_keymap
  buf_map(0, 'n', '<leader>rc', '<Plug>(IPy-RunCell)', {silent = true})
  buf_map(0, 'n', '<leader>ra', '<Plug>(IPy-RunAll)', {silent = true})
  buf_map(0, 'n', '<leader>rr', '<Plug>(IPy-Run)', {silent = true})
  buf_map(0, 'v', '<leader>rr', '<Plug>(IPy-Run)', {silent = true})
  buf_map(0, 'n', ']c', '/# %%$<cr>:noh<cr>j', {silent = true, noremap = true})
  buf_map(0, 'n', '[c', '?# %%$<cr>n:noh<cr>j', {silent = true, noremap = true})
end


vim.cmd[[
  command! -nargs=1 JupyterQtConsole lua require'jupyter_integration'.start_qtconsole(<args>)
  command! -nargs=0 JupyterConnect lua require'jupyter_integration'.connect_to_qtconsole()
]]

return m
