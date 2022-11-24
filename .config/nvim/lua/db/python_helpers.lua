local m = {}

--- Returns version of current python interpreter.
function m.get_python_version()
  local curr_python_version = vim.fn.system [[
    python -c "import sys; v = sys.version_info;print(f'{v[0]}.{v[1]}.{v[2]}', end='')";
  ]]

  return curr_python_version
end

return m
