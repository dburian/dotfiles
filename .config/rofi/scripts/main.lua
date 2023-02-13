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

function funcs.bluetooth_menu()
  local cmd_info = lib.get_cmd_output("bluetoothctl show | grep 'Powered: yes'", true)
  local status = #cmd_info > 0 and 'powered' or 'off'



  return { {
    text = "bluetooth (" .. status .. ")",
    options = {
      info = "bluetooth_connections"
    }
  } }
end

function funcs.bluetooth_connections()
  local devices = lib.get_cmd_output("bluetoothctl devices | cut -d ' ' -f 2-", true)

  local btl_info = lib.get_cmd_output("bluetoothctl show | grep 'Powered: yes'", true)
  local toggle_text = #btl_info > 0 and 'bluetooth off' or 'bluetooth on'

  local entries = {
    {
      text = toggle_text,
      options = {
        info = 'bluetooth_toggle_state'
      }
    }
  }
  for _, device in ipairs(devices) do
    local end_addr_ind = string.find(device, ' ')
    local device_addr = string.sub(device, 1, end_addr_ind)
    local device_name = string.sub(device, end_addr_ind + 1)
    local device_connection_cmd = lib.get_cmd_output("bluetoothctl info " .. device_addr .. " | grep 'Connected: yes'",
      true)
    local connection_status = #device_connection_cmd > 0 and 'disconnect ' or 'connect '
    table.insert(entries, {
      text = connection_status .. device_name,
      options = {
        info = "bluetooth_connect",
      }
    })
  end


  return entries
end

function funcs.bluetooth_connect(selection)
  if selection then
    local end_ind_verb = string.find(selection, ' ')
    local verb = string.sub(selection, 1, end_ind_verb)
    local device_name = string.sub(selection, end_ind_verb + 1)
    local device_addr = lib.get_cmd_output("bluetoothctl devices | grep '" .. device_name .. "' | cut -d ' ' -f 2")
    if verb then
      lib.execute_cmd("bluetoothctl " .. verb .. " " .. device_addr, true)
    end
    return nil
  end
end

function funcs.bluetooth_toggle_state(selection)
  local onoff = selection == 'bluetooth on' and 'on' or 'off'

  lib.execute_cmd('bluetoothctl power ' .. onoff)

  if onoff == 'on' then
    return funcs.bluetooth_connections()
  end
end

local INIT_FUNCS = {
  funcs.power,
  funcs.apps,
  funcs.wifi_menu,
  funcs.bluetooth_menu,
}

lib.main(INIT_FUNCS, funcs, arg)
