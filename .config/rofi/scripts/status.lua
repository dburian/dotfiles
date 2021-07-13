#!/bin/lua

--[[
Generates non-selectable rows, each giving information about the system.
]]

local os = require('os')
local io = require('io')

local opt_sep = '\x1f'
local opts_prefix = '\0'
local row_sep = '\n'

function get_date_time()
  return os.date('%d.%m %H:%M')
end

function get_battery()
  local perc_file = '/sys/class/power_supply/BAT1/capacity'
  local state_file = '/sys/class/power_supply/BAT1/status'

  local perc = io.lines(perc_file)()
  local state = io.lines(state_file)()

  return perc .. '%' .. ' (' .. state .. ')'
end

function get_kb_layout()
  local cmd = 'xkblayout_state print "%s"'

  local cmd_handle = io.popen(cmd)
  local layout_name = cmd_handle:lines()()
  cmd_handle:close()

  return layout_name
end

function get_brightness()
  local cmd = 'xbacklight -get'

  local output_handle = io.popen(cmd)
  local backlight_perc = output_handle:lines()()
  output_handle:close()

  return backlight_perc .. '%'
end

function get_volume()
  local cmd = 'pacmd list-sinks | grep "volume" | head -n 1 | cut -d "/" -f 2'

  local output_handle = io.popen(cmd)
  local volume_on_default_sink = output_handle:lines()()
  output_handle:close()

  return volume_on_default_sink:gmatch('([^%s]+)')()
end


local readings = {
  {
    label = 'Time',
    func = get_date_time,
    options = {
      meta = 'date',
    },
  },
  {
    label = 'Battery',
    func = get_battery,
  },
  {
    label = 'Keyboard layout',
    func = get_kb_layout,
  },
  {
    label = 'Brightness',
    func = get_brightness,
  },
  {
    label = 'Volume',
    func = get_volume,
  }
}

local rows_options = {
  ['no-custom'] = 'true',
  ['markup-rows'] = 'true',
}

local str = ''

--Setting global options
for k, v in pairs(rows_options) do
  str = str .. opts_prefix .. k .. opt_sep .. v .. row_sep
end

--Printing rows
for _, r in ipairs(readings) do
  str = str .. r.label .. ':    ' .. '<i>' .. r.func() .. '</i>'

  str = str .. opts_prefix .. 'nonselectable' .. opt_sep .. 'true'

  if r.options then
    for opt_key, opt_value in pairs(r.options) do
      str = str .. opt_sep .. opt_key .. opt_sep .. opt_value
      first = false
    end
  end

  str = str .. row_sep
end


print(str)
