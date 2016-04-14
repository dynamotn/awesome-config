-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget and layout library
local wibox = require("wibox")
local gears = require("gears")

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
-- }}}

-- {{{ Make a powerline section
dynamo.section = function(image, color_prev, color_current)
    local section = {}

    section.arrow = dynamo.arrow_left(color_prev, color_current)

    section.icon = wibox.widget.background()
    section.icon:set_bg(color_current)
    section.icon:set_widget(wibox.widget.imagebox(image))

    section.text = wibox.widget.textbox()
    section.info = wibox.widget.background()
    section.info:set_bg(color_current)
    section.info:set_widget(section.text)

    return section
end
-- }}}
