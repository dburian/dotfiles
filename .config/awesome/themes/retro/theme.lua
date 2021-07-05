local awful = require("awful")
local wibox = require("wibox")
local debug = require('gears.debug')
local naughty = require('naughty')

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local battery_widget = require("themes.retro.battery_widget")

local theme = {}

theme.font          = "Latin Modern Mono 12"

theme.bg_normal     = "#ededce"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#000000"
theme.fg_focus      = "#ededce"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap         = dpi(6)
theme.border_width        = dpi(2)
theme.border_color_normal = "#242424"
theme.border_color_active = "#ededce"
theme.border_color_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.wallpaper = "~/Pictures/wallpapers/sequioa_alley.jpeg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Wibar
theme.wibar = function(s)
    -- Creating widgets inside (after beautiful library init)
    -- Keyboard map indicator and switcher
    keyboard_layout = awful.widget.keyboardlayout()

    -- Create a textclock widget
    clock = wibox.widget.textclock('%-d.%-m. %H:%M', 60)

    bat_widget = battery_widget()


    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
        layout = {
            spacing = 6,
            layout = wibox.layout.fixed.horizontal,
        }
    }


    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "bottom",
        screen = s,
        height = dpi(28),
        bg = "#ededce",
    })


    -- Add widgets to the wibox
    s.mywibox.widget = wibox.container.margin(
        {
            layout = wibox.layout.align.horizontal,
            s.mytaglist,
            wibox.container.place(
                --TODO: widgets heree
                clock,
                "center",
                "center"
            ),
            wibox.container.place(
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 15,
                    keyboard_layout,
                    bat_widget,
                    clock,
                },
                "right",
                "center"
            )
        },
        12,
        12
    )
end

--TODO: create a icon-text widget type, kb layout, brightness, volume
screen.connect_signal('global::volume_changed', function(...)
    print('volume changed')
    debug.dump(arg)
    naughty.notify({
        text = tostring(arg)
    })
end)

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
