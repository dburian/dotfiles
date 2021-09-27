#!/bin/lua

-- The one and only rofi script

local OPT_SEP = '\x1f'
local OPT_PREFIX = '\0'
local ROW_SEP = '\n'

local global_options = {
  ['no-custom'] = 'true',
  ['markup-rows'] = 'true',
}

local lib = {}

function lib.get_cmd_output(cmd, multiple_lines)
  local output_handle = io.popen(cmd)

  local output
  if multiple_lines then
    local str = output_handle:lines('a')()
    output = {}
    for line in string.gmatch(str, '([^\n]+)') do
      table.insert(output, line)
    end
  else
    output = output_handle:lines()()
  end

  output_handle:close()

  return output
end
function lib.execute_cmd(cmd)
  os.execute(cmd .. '> /dev/null 2>&1')
end

function lib.format_global_options(global_options)
  local str = ''
  for k, v in pairs(global_options) do
    str = str .. OPT_PREFIX .. k .. OPT_SEP .. v .. ROW_SEP
  end

  return str
end
function lib.format_row(label, text, options)
  local str = ''
  str = str .. label .. '    ' .. '<i>' .. text .. '</i>'

  if options then

    local opt_key = next(options)

    str = str .. OPT_PREFIX .. opt_key .. OPT_SEP .. options[opt_key]

    opt_key = next(options, opt_key)
    while opt_key ~= nil do
      str = str .. OPT_SEP .. opt_key .. OPT_SEP .. options[opt_key]
      opt_key = next(options, opt_key)
    end
  end

  return str .. ROW_SEP
end
function lib.format_rows(rows_spec)
  local str = ''

  for _, r in ipairs(rows_spec) do
    str = str .. lib.format_row(r.label, r.func(), r.options)
  end

  return str
end
function lib.parse_selection(rows, arg)
  local selected_row_text = string.match(arg[1], '<i>([^<]*)</i>')
  local selected_info = os.getenv('ROFI_INFO')

  for _, r in ipairs(rows) do
    if r.options.info == selected_info then
      local nested_rows = r.func(selected_row_text)
      if nested_rows then
        local str = lib.format_global_options(global_options)
        str = str .. lib.format_rows(nested_rows)

        print(str)
      end

      break
    end
  end
end

local status = {}

function status.get_date_time()
  return os.date('%d.%m %H:%M')
end
function status.get_battery()
  local perc_file = '/sys/class/power_supply/BAT1/capacity'
  local state_file = '/sys/class/power_supply/BAT1/status'

  local perc = io.lines(perc_file)()
  local state = io.lines(state_file)()

  return perc .. '%' .. ' (' .. state .. ')'
end
function status.get_kb_layout()
  local cmd = 'xkblayout_state print "%s"'

  return lib.get_cmd_output(cmd)
end
function status.get_brightness()
  local cmd = 'xbacklight -get'

  return lib.get_cmd_output(cmd) .. '%'
end
function status.get_volume()
  local cmd = 'pacmd list-sinks | grep "volume" | head -n 1 | cut -d "/" -f 2'

  local volume_on_default_sink = lib.get_cmd_output(cmd)
  return volume_on_default_sink:gmatch('([^%s]+)')()
end

local radio = {}

function radio.wifi_toggle(selection)
  if selection then
    if selection == 'enabled' then
      lib.execute_cmd('nmcli radio wifi off')
    else
      lib.execute_cmd('nmcli radio wifi on')
    end

    return nil
  end

  local cmd = 'nmcli radio wifi'

  return lib.get_cmd_output(cmd)
end
function radio.wifi_connect(selection)
  local active_connection = lib.get_cmd_output('nmcli -f NAME connection show --active', true)[2]

  if selection then
    if selection == active_connection then
      local rows = {}

      for _, ssid in ipairs(radio.wifi_list_available_SSIDs()) do
        table.insert(rows, {
            label = 'WIFI CONN',
            func = function () return ssid end,
            options = {
              info = 'wifi_connect'
            }
        })
      end

      return rows
    else
      lib.execute_cmd('ncmli connection up ' .. selection)

      return nil
    end
  end

  return active_connection
end
function radio.wifi_list_available_SSIDs()
  local ssids = lib.get_cmd_output('nmcli -f SSID device wifi list', true)

  table.remove(ssids, 1) --remove header

  return ssids
end

local programs = {}

function programs.vivaldi(selection)
  if selection then
    lib.execute_cmd('exec vivaldi-stable')
    return nil
  end

  return 'vivaldi'
end

local rows = {
  {
    label = 'DATE TIME',
    func = status.get_date_time,
    options = {
      nonselectable = 'true'
    },
  },
  {
    label = 'BATT CAPA',
    func = status.get_battery,
    options = {
      nonselectable = 'true'
    }
  },
  {
    label = 'KEYB LAYO',
    func = status.get_kb_layout,
    options = {
      nonselectable = 'true'
    }
  },
  {
    label = 'BRIG LEVE',
    func = status.get_brightness,
    options = {
      nonselectable = 'true'
    }
  },
  {
    label = 'VOLU LEVE',
    func = status.get_volume,
    options = {
      nonselectable = 'true'
    }
  },
  {
    label = 'WIFI TOGG',
    func = radio.wifi_toggle,
    options = {
      info = 'toggle_wifi',
    }
  },
  {
    label = 'WIFI CONN',
    func = radio.wifi_connect,
    options = {
      info = 'wifi_connect',
    }
  },
  {
    label = 'EXEC PROG',
    func = programs.vivaldi,
    options = {
      info = 'vivaldi'
    }
  }
}

if #arg > 0 then
  lib.parse_selection(rows, arg)
else
  local str = lib.format_global_options(global_options)
  str = str .. lib.format_rows(rows)
  print(str)
end
