local wibox = require('wibox')

function icon_widget(image_path)
    local widget = wibox.widget {
        {
            {
                id = 'icon',
                widget = wibox.widget.imagebox,
                resize = true,
            },
            layout = wibox.container.margin,
            top = 7,
            bottom = 6,
        },
        {
            widget = wibox.widget.textbox,
            id = 'text',
        },
        layout = wibox.layout.fixed.horizontal
    }

    if image_path then
        widget:get_children_by_id('icon')[1]:set_image(image_path)
    end

    return widget
end

return icon_widget
