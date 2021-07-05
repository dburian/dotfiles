local awful = require('awful')
local wibox = require('wibox')
local naughty = require('naughty')

local icon_widget = require('themes.retro.icon_widget')

-- for debug
local debug = require('gears.debug')

local icons_path = os.getenv('HOME') .. '/.config/awesome/themes/retro/battery_icons'
local icons = {
    half = icons_path .. '/50.png',
    low = icons_path .. '/10.png',
    high = icons_path .. '/90.png',
    charging = icons_path .. '/charging.png',
}

local bat_path = '/sys/class/power_supply/BAT1'
local capacity_path = bat_path .. '/capacity'
local status_path = bat_path .. '/status'
local get_battery_cmd = 'cat ' .. capacity_path .. ' ' .. status_path

function battery_widget()
    --TODO: rewrite this with dbus for more instanenous feedback
    local notification = nil
    local update_bat = function(widget, stdout)
        local lines_iter = stdout:gmatch('[^\r\n]+')
        local cap = tonumber(lines_iter())
        local status = lines_iter()

        local icon_widget = widget:get_children_by_id('icon')[1]
        local text_widget = widget:get_children_by_id('text')[1]

        if status == 'Charging' then
            icon_widget:set_image(icons.charging)

            if notification then
                naughty.destroy(
                    notification,
                    naughty.notificationClosedReason.dismissedByCommand
                )
                notification = nil
            end
        elseif cap > 90 then
            icon_widget:set_image(icons.high)
        elseif cap > 10 then
            icon_widget:set_image(icons.half)
        else
            icon_widget:set_image(icons.low)
        end

        if notification == nil and cap < 5 then
            notification = naughty.notify({
                title = 'Critical battery',
                text = 'Battery is at ' .. cap .. '% and falling.',
                timeout = 0,
            })
        end

        text_widget:set_text(cap .. '%')
    end

    return awful.widget.watch(get_battery_cmd, 10, update_bat, icon_widget())
end

return battery_widget
