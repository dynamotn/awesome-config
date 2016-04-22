-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget and layout library
local wibox = require("wibox")
local gears = require("gears")
local common = require("awful.widget.common")

-- {{{ Draw arrow same powerline
dynamo.arrow_left = function(color1, color2)
    -- Create new widget
    local widget = wibox.widget.base.make_widget()

    -- Get width and height same with base widget that current widget put on
    widget.fit = function(widget, width, height)
        return height / 2, height
    end

    widget.draw = function(mycross, wibox, cairo, width, height)
        if color1 ~= "opaque" then
            cairo:set_source_rgb(gears.color.parse_color(color1))
            cairo:new_path()
            cairo:move_to(0, height / 2)
            cairo:line_to(width, 0)
            cairo:line_to(0, 0)
            cairo:close_path()
            cairo:fill()

            cairo:new_path()
            cairo:move_to(0, height / 2)
            cairo:line_to(width, height)
            cairo:line_to(0, height)
            cairo:close_path()
            cairo:fill()
        end

        if color2 ~= "opaque" then
            cairo:set_source_rgb(gears.color.parse_color(color2))
            cairo:new_path()
            cairo:move_to(width, 0)
            cairo:line_to(0, height / 2)
            cairo:line_to(width, height)
            cairo:close_path()

            cairo:fill()
        end
   end

   return widget
end

dynamo.arrow_right = function(color1, color2)
    -- Create new widget
    local widget = wibox.widget.base.make_widget()

    -- Get width and height same with base widget that current widget put on
    widget.fit = function(widget, width, height)
        return height / 2, height
    end

    widget.draw = function(mycross, wibox, cairo, width, height)
        if color2 ~= "opaque" then
            cairo:set_source_rgb(gears.color.parse_color(color2))
            cairo:new_path()
            cairo:move_to(width, height / 2)
            cairo:line_to(0, 0)
            cairo:line_to(width, 0)
            cairo:close_path()
            cairo:fill()

            cairo:new_path()
            cairo:move_to(width, height / 2)
            cairo:line_to(0, height)
            cairo:line_to(width, height)
            cairo:close_path()
            cairo:fill()
        end

        if color1 ~= "opaque" then
            cairo:set_source_rgb(gears.color.parse_color(color1))
            cairo:new_path()
            cairo:move_to(0, 0)
            cairo:line_to(width, height / 2)
            cairo:line_to(0, height)
            cairo:close_path()

            cairo:fill()
        end
   end

   return widget
end
-- }}}

-- {{{ Draw arrow not fill
dynamo.arrow_border_left = function(color)
    -- Create new widget
    local widget = wibox.widget.base.make_widget()

    -- Get width and height same with base widget that current widget put on
    widget.fit = function(widget, width, height)
        return height / 2, height
    end

    widget.draw = function(mycross, wibox, cairo, width, height)
        cairo:set_source_rgb(gears.color.parse_color(color))
        cairo:new_path()
        cairo:move_to(width, 0)
        cairo:line_to(width - 1, 0)
        cairo:line_to(0, height / 2 - 1)
        cairo:line_to(0, height / 2 + 1)
        cairo:line_to(width - 1, height)
        cairo:line_to(width, height)
        cairo:line_to(width, height - 1)
        cairo:line_to(1, height / 2)
        cairo:line_to(width, 1)
        cairo:close_path()

        cairo:fill()
   end

   return widget
end

dynamo.arrow_border_right = function(color)
    -- Create new widget
    local widget = wibox.widget.base.make_widget()

    -- Get width and height same with base widget that current widget put on
    widget.fit = function(widget, width, height)
        return height / 2, height
    end

    widget.draw = function(mycross, wibox, cairo, width, height)
        cairo:set_source_rgb(gears.color.parse_color(color))
        cairo:new_path()
        cairo:move_to(0, 0)
        cairo:line_to(1, 0)
        cairo:line_to(width, height / 2 - 1)
        cairo:line_to(width, height / 2 + 1)
        cairo:line_to(1, height)
        cairo:line_to(0, height)
        cairo:line_to(0, height - 1)
        cairo:line_to(width - 1, height / 2)
        cairo:line_to(0, 1)
        cairo:close_path()

        cairo:fill()
   end

   return widget
end
-- }}}

-- {{{ Make a powerline section
dynamo.section = function(image, color_prev, color_current)
    local section = {}

    section.arrow = dynamo.arrow_left(color_prev, color_current)

    section.icon = wibox.widget.background(wibox.widget.imagebox(image), color_current)

    section.text = wibox.widget.textbox()
    section.info = wibox.widget.background(section.text, color_current)

    return section
end
-- }}} 

-- {{{ Update taglist
dynamo.update_taglist = function(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local ib, tb, bgb, m, l
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            m   = cache.m
        else
            ib = wibox.widget.imagebox()
            tb = dynamo.widget.label()
            bgb = wibox.widget.background()
            m = wibox.layout.margin(tb, 4, 4)
            l = wibox.layout.fixed.horizontal()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(ib)
            l:add(m)

            -- And all of this gets a background
            bgb:set_widget(l)

            bgb:buttons(common.create_buttons(buttons, o))

            data[o] = {
                ib = ib,
                tb = tb,
                bgb = bgb,
                m   = m
            }
        end

        local text, bg, bg_image, icon = label(o)
        -- The text might be invalid, so use pcall
        if not pcall(tb.set_markup, tb, text) then
            tb:set_markup("<i>&lt;Invalid text&gt;</i>")
        end
        bgb:set_bg(bg)
        if type(bg_image) == "function" then
            bg_image = bg_image(tb,o,m,objects,i)
        end
        bgb:set_bgimage(bg_image)
        ib:set_image(icon)
        w:add(bgb)
   end
end
-- }}}