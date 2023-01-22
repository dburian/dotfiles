#!/bin/lua

package.path = package.path .. ";/home/dburian/.config/rofi/scripts/lib.lua"
local lib = require("lib")

-- The one and only rofi script
local APPS = {
  {
    name = 'spotify',
    command = 'spotify',
  },
  {
    name = 'vivaldi',
    command = 'vivaldi-stable',
  },
  {
    name = 'blender',
    command = 'bledner',
  },
  {
    name = 'gimp',
    command = 'gimp',
  },
  {
    name = 'thunderbird',
    command = 'thunderbird',
  },
  {
    name = 'configure wacom',
    command = 'config_wacom',
  },
  {
    name = 'thunderbird',
    command = 'thunderbird',
  },
  {
    name = 'zeal',
    command = 'zeal',
  },
  {
    name = 'font manager',
    command = 'font-manager',
  },
  {
    name = 'inkscape',
    command = 'inkscape',
  },
  {
    name = 'clipmenu',
    command = 'clipmenu -dmenu -p Clipmenu',
  },
}

local get_wifi_state = function()
  return lib.get_cmd_output('nmcli -g WIFI general')
end

local funcs = {}

function funcs.wifi_menu()
  local wifi_state = get_wifi_state()

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
  local wifi_state = get_wifi_state()
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

function funcs.apps(selection)
  if selection then
    for _, app in ipairs(APPS) do
      if app.name == selection then
        lib.execute_cmd(app.command, true)
        return nil
      end
    end
  end

  local rows = {}
  for _, app in ipairs(APPS) do
    table.insert(rows, {
      text = app.name,
      options = {
        info = 'apps'
      }
    })
  end

  return rows

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

local INIT_FUNCS = {
  funcs.power,
  funcs.apps,
  funcs.wifi_menu,
}

lib.main(INIT_FUNCS, funcs, arg)
