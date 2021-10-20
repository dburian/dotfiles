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

local funcs = {}

function funcs.get_date_time()
  return {{
    label = 'DATE TIME',
    text = os.date('%d.%m %H:%M'),
  }}
end
function funcs.get_battery()
  local perc_file = '/sys/class/power_supply/BAT1/capacity'
  local state_file = '/sys/class/power_supply/BAT1/status'

  local perc = io.lines(perc_file)()
  local state = io.lines(state_file)()

  return {{
    label = 'BATT CAPA',
    text = perc .. '%' .. ' (' .. state .. ')',
  }}
end
function funcs.get_kb_layout(selection)
  if selection then
    lib.execute_cmd('xkblayout-state set +1')

    return nil
  end

  return {{
      label = 'KEYB LAYO',
      text = lib.get_cmd_output('xkblayout-state print "%s"'),
      options = {
        info = 'get_kb_layout'
      }
  }}
end
function funcs.brightness(selection)
  if selection then
    local num = tonumber(string.match(selection, '(%d+)%%'))

    lib.execute_cmd('xbacklight -set ' .. (num > 50 and '1' or '100'))

    return nil
  end

  return {{
      label = 'BACK BRIG',
      text = lib.get_cmd_output('xbacklight -get') .. '%',
      options = {
        info = 'brightness',
        meta = 'brightness'
      }
  }}
end
function funcs.volume()
  local cmd = 'pacmd list-sinks | grep "volume" | head -n 1 | cut -d "/" -f 2'

  local volume_on_default_sink = lib.get_cmd_output(cmd)

  return {{
      label = 'VOLU LEVE',
      text = volume_on_default_sink:match('([^%s]+)'),
  }}
end

function funcs.connections_menu()
  local connectivity, wifi_state = string.match(
    lib.get_cmd_output(
      'nmcli -g STATE,WIFI general'
    ),
    '([^:]+):([^:]+)'
  )

  local active_connection = nil
  if connectivity ~= 'disconnected' then
    active_connection = lib.get_cmd_output('nmcli -g NAME connection show --active')
  end

  return {
    {
      label = 'WIFI STAT',
      text = wifi_state,
      options = {
        info = 'wifi_state'
      }
    },
    {
      label = 'INTE CONN',
      text = active_connection and connectivity .. ' to ' .. active_connection or connectivity,
      options = wifi_state == 'enabled' and {
        info = 'wifi_list_connections'
      } or nil
    }
  }

end
function funcs.wifi_list_connections()
  local available_SSIDs = lib.get_cmd_output('nmcli -g SSID,RATE,SIGNAL,SECURITY,IN-USE device wifi list', true)

  local rows = {
    {
      label = 'WIFI CONN',
      text = '--refresh--',
      options = {
        info = 'wifi_list_connections'
      }
    }
  }

  for _, ssid in ipairs(available_SSIDs) do
    local props = lib.string_split(ssid, ':')

    table.insert(rows, {
      label = 'WIFI CONN',
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

  -- (<cmd> &) executes the command asychronously
  local cmd = '(nmcli device wifi connect "' .. ssid .. '" &)'

  lib.execute_cmd(cmd)

  return nil
end
function funcs.wifi_state(selection)
  local onoff = selection == 'enabled' and 'off' or 'on'
  lib.execute_cmd('nmcli radio wifi ' .. onoff)

  return nil
end

function funcs.vivaldi(selection)
  if selection then
    lib.execute_cmd('vivaldi-stable', true)

    return nil
  end

  return {{
    label = 'EXEC PROG',
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
    label = 'EXEC PROG',
    text = 'blender',
    options = {
      info = 'blender',
    }
  }}
end
function funcs.android_emulator(selection)
  if selection then
    lib.execute_cmd('zsh -c "emulator -avd api_30 -gpu host"', true)

    return nil
  end

  return {{
    label = 'EXEC PROG',
    text = 'android emulator',
    options = {
      info = 'android_emulator',
    }
  }}
end

function funcs.clipboard(selection)
  if selection then
    lib.execute_cmd('clipmenu -dmenu -p Clipmenu', true)

    return nil
  end

  return {{
    label = 'CLIP BOAR',
    text = 'clipmenu',
    options = {
      info = 'clipboard'
    }
  }}
end

local initial_func = function()
  local init_funcs = {
    funcs.get_date_time,
    funcs.get_battery,
    funcs.brightness,
    funcs.volume,
    funcs.get_kb_layout,
    funcs.connections_menu,
    funcs.clipboard,
    funcs.vivaldi,
    funcs.blender,
    funcs.android_emulator,
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
  str = str .. row.label .. '    ' .. '<i>' .. row.text .. '</i>'

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
  local selected_row_text = string.match(arg[1], '<i>(.+)</i>$')

  for k, f in pairs(funcs) do
    if k == selected_info then
      print_func(f, selected_row_text)
    end
  end
else
  print_func(initial_func)
end
