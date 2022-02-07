#!/bin/lua

-- The one and only rofi script

local OPT_SEP = '\x1f'
local OPT_PREFIX = '\0'
local ROW_SEP = '\n'

local DEF_GLOB_OPTIONS = {
    ['no-custom'] = 'true',
    ['markup-rows'] = 'true',
}

local lib = {}

function lib.string_split(str, sep)
  local segments = {}

  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    table.insert(segments, s)
  end

  return segments
end
function lib.get_cmd_output(cmd, multiple_lines)
  local output_handle = io.popen(cmd)

  local output
  if multiple_lines then
    output = lib.string_split(output_handle:lines('a')(), '\n')
  else
    output = output_handle:lines()()
  end

  output_handle:close()

  return output
end
function lib.execute_cmd(cmd, background)

  cmd = cmd .. ' < /dev/null > /dev/null 2>&1'
  if background then
    cmd = 'setsid ' .. cmd .. ' &'
  end

  os.execute(cmd)
end
function lib.get_wifi_state()
  return lib.get_cmd_output('nmcli -g WIFI general')
end

local funcs = {}

function funcs.wifi_menu()
  local wifi_state = lib.get_wifi_state()

  return {
    {
      text = 'wifi (' .. wifi_state .. ')',
      options = {
        info = 'wifi_list_connections'
      }
    }
  }
end
function funcs.wifi_list_connections()
  local available_SSIDs = lib.get_cmd_output('nmcli -g SSID,RATE,SIGNAL,SECURITY,IN-USE device wifi list', true)
  local wifi_state = lib.get_wifi_state()
  local toggle_wifi = wifi_state == 'enabled' and 'off' or 'on'

  local rows = {
    {
      text = '--refresh--',
      options = {
        info = 'wifi_list_connections'
      }
    },
    {
      text = 'wifi ' .. toggle_wifi,
      options = {
        info = 'wifi_toggle_state'
      }
    },
  }

  for _, ssid in ipairs(available_SSIDs) do
    local props = lib.string_split(ssid, ':')

    table.insert(rows, {
      text = table.concat(props, '   '),
      options = {
        info = 'wifi_connect'
      }
    })
  end

  return rows
end

function funcs.wifi_connect(selection)
  local ssid = lib.string_split(selection, ' ')[1]

  local cmd = '(nmcli device wifi connect "' .. ssid .. '" &)'

  lib.execute_cmd(cmd)

  return nil
end
function funcs.wifi_toggle_state(selection)
  local onoff = selection == 'wifi off' and 'off' or 'on'
  lib.execute_cmd('nmcli radio wifi ' .. onoff, true)

  if onoff == 'on' then
    return funcs.wifi_list_connections()
  end

  return nil
end

function funcs.vivaldi(selection)
  if selection then
    lib.execute_cmd('vivaldi-stable', true)

    return nil
  end

  return {{
    text = 'vivaldi',
    options = {
      info = 'vivaldi',
    }
  }}
end
function funcs.blender(selection)
  if selection then
    lib.execute_cmd('blender', true)

    return nil
  end

  return {{
    text = 'blender',
    options = {
      info = 'blender',
    }
  }}
end
function funcs.postman(selection)
  if selection then
    lib.execute_cmd('postman', true)

    return nil
  end

  return {{
    text = 'postman',
    options = {
      info = 'postman',
    }
  }}
end
function funcs.slack(selection)
  if selection then
    lib.execute_cmd('slack', true)

    return nil
  end

  return {{
    text = 'slack',
    options = {
      info = 'slack',
    }
  }}
end
function funcs.android_emulator(selection)
  if selection then
    lib.execute_cmd('flutter emulators --launch api_30', true)

    return nil
  end

  return {{
    text = 'android emulator',
    options = {
      info = 'android_emulator',
    }
  }}
end
function funcs.spotify(selection)
  if selection then
    lib.execute_cmd('spotify', true)
    return nil
  end

  return {{
    text = 'spotify',
    options = {
      info = 'spotify',
    }
  }}
end
function funcs.gimp(selection)
  if selection then
    lib.execute_cmd('gimp', true)
    return nil
  end

  return {{
    text = 'gimp',
    options = {
      info = 'gimp',
    }
  }}
end
function funcs.mailspring(selection)
  if selection then
    lib.execute_cmd('mailspring', true)
    return nil
  end

  return {{
    text = 'mailspring',
    options = {
      info = 'mailspring',
    }
  }}
end

function funcs.power(selection)
  if selection == 'shutdown' then
    lib.execute_cmd('shutdown now', true)
    return nil
  elseif selection == 'reboot' then
    lib.execute_cmd('shutdown -r now', true)
    return nil
  elseif selection == 'hibernate' then
    lib.execute_cmd('systemctl hibernate', true)
    return nil
  end

  return {
    {
      text = 'shutdown',
      options = {
        info = 'power'
      }
    },
    {
      text = 'reboot',
      options = {
        info = 'power',
      }
    },
    {
      text = 'hibernate',
      options = {
        info = 'power',
      }
    }
  }
end

function funcs.clipboard(selection)
  if selection then
    lib.execute_cmd('clipmenu -dmenu -p Clipmenu', true)

    return nil
  end

  return {{
    text = 'clipmenu',
    options = {
      info = 'clipboard'
    }
  }}
end

local initial_func = function()
  local init_funcs = {
    funcs.wifi_menu,
    funcs.clipboard,
    funcs.vivaldi,
    funcs.blender,
    funcs.postman,
    funcs.slack,
    funcs.gimp,
    funcs.mailspring,
    funcs.android_emulator,
    funcs.power,
    funcs.spotify,
  }

  local rows = {}

  local i = next(init_funcs)
  while i do
    local new_rows = init_funcs[i]()

    for _, r in ipairs(new_rows) do
      table.insert(rows, r)
    end

    i = next(init_funcs, i)
  end

  return rows
end

local format_global_options = function(global_options)
  local str = ''
  for k, v in pairs(global_options) do
    str = str .. OPT_PREFIX .. k .. OPT_SEP .. v .. ROW_SEP
  end

  return str
end
local format_row = function(row)
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
local format_rows = function(rows_spec)
  local str = ''

  for _, r in ipairs(rows_spec) do
    str = str .. format_row(r)
  end

  return str
end
local print_func = function(func, selection)
  local rows, global_options = func(selection)

  if not rows then
    return
  end

  local str = format_global_options(global_options or DEF_GLOB_OPTIONS)
  str = str .. format_rows(rows)

  print(str)
end

if #arg > 0 then
  local selected_info = os.getenv('ROFI_INFO')
  local selected_row_text = string.match(arg[1], '(.+)')

  for k, f in pairs(funcs) do
    if k == selected_info then
      print_func(f, selected_row_text)
    end
  end
else
  print_func(initial_func)
end
