local m = {}

local OPT_SEP = '\x1f'
local OPT_PREFIX = '\0'
local ROW_SEP = '\n'

local DEF_GLOB_OPTIONS = {
  ['no-custom'] = 'true',
  ['markup-rows'] = 'true',
}

function m.string_split(str, sep)
  local segments = {}

  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    table.insert(segments, s)
  end

  return segments
end

function m.get_cmd_output(cmd, multiple_lines)
  local output_handle = io.popen(cmd)

  local output
  if multiple_lines then
    output = m.string_split(output_handle:lines('a')(), '\n')
  else
    output = output_handle:lines()()
  end

  output_handle:close()

  return output
end

function m.execute_cmd(cmd, background)

  cmd = cmd .. ' < /dev/null > /dev/null 2>&1'
  if background then
    cmd = 'setsid ' .. cmd .. ' &'
  end

  os.execute(cmd)
end

function m.format_global_options(global_options)
  local str = ''
  for k, v in pairs(global_options) do
    str = str .. OPT_PREFIX .. k .. OPT_SEP .. v .. ROW_SEP
  end

  return str
end

function m.format_row(row)
  local str = ''

  if row.label then
    str = str .. row.label .. ' '
  end

  str = str .. row.text

  if row.options then

    local opt_key = next(row.options)

    str = str .. OPT_PREFIX .. opt_key .. OPT_SEP .. row.options[opt_key]

    opt_key = next(row.options, opt_key)
    while opt_key ~= nil do
      str = str .. OPT_SEP .. opt_key .. OPT_SEP .. row.options[opt_key]
      opt_key = next(row.options, opt_key)
    end
  end

  return str .. ROW_SEP
end

function m.format_rows(rows_spec)
  local str = ''

  for _, r in ipairs(rows_spec) do
    str = str .. m.format_row(r)
  end

  return str
end

function m.print_func(func, selection)
  local rows, global_options = func(selection)

  if not rows then
    return
  end

  local str = m.format_global_options(global_options or DEF_GLOB_OPTIONS)
  str = str .. m.format_rows(rows)

  print(str)
end

function m.print_all_funcs(funcs)
  for _, func in ipairs(funcs) do
    m.print_func(func)
  end
end

function m.main(init_funcs, all_funcs, arg)
  local is_init_call = tonumber(os.getenv('ROFI_RETV')) == 0
  if is_init_call then
    m.print_all_funcs(init_funcs)
    return
  end

  if #arg > 0 then
    local selected_info = os.getenv('ROFI_INFO')
    local selected_row_text = string.match(arg[1], '(.+)')

    for k, f in pairs(all_funcs) do
      if k == selected_info then
        m.print_func(f, selected_row_text)
      end
    end
  end
end

return m
