-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget and layout library
local wibox = require("wibox")
local gears = require("gears")
local common = require("awful.widget.common")
local util = require("awful.util")
local html = require("html")

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

    function section:buttons(_buttons)
        section.icon:buttons(_buttons)
        section.info:buttons(_buttons)
    end

    function section:connect_signal(signal, execute)
        section.icon:connect_signal(signal, execute)
        section.info:connect_signal(signal, execute)
    end

    return section
end
-- }}}

-- {{{ Update taglist
local function decorate_taglist(t)
    local theme = beautiful.get()
    local fg_focus = theme.taglist_fg_focus or theme.fg_focus
    local bg_focus = theme.taglist_bg_focus or theme.bg_focus
    local fg_urgent = theme.taglist_fg_urgent or theme.fg_urgent
    local bg_urgent = theme.taglist_bg_urgent or theme.bg_urgent
    local bg_occupied = theme.taglist_bg_occupied
    local fg_occupied = theme.taglist_fg_occupied
    local bg_empty = theme.taglist_bg_empty
    local fg_empty = theme.taglist_fg_empty
    local font = theme.taglist_font or theme.font or ""
    local text = ""
    local sel = client.focus
    local bg_color = nil
    local fg_color = nil
    local state = nil
    local cls = t:clients()
    if #cls > 0 then
        if bg_occupied then bg_color = bg_occupied end
        if fg_occupied then fg_color = fg_occupied end
        state = "occupied"
    else
        if bg_empty then bg_color = bg_empty end
        if fg_empty then fg_color = fg_empty end
        state = "empty"
    end
    for k, c in pairs(cls) do
        if c.urgent then
            if bg_urgent then bg_color = bg_urgent end
            if fg_urgent then fg_color = fg_urgent end
            state = "urgent"
            break
        end
    end
    if t.selected then
        bg_color = bg_focus
        fg_color = fg_focus
        state = "focus"
    end
    text = html.font(font, html(fg_color, util.escape(t.name)))

    return text, bg_color, state
end

dynamo.update_taglist = function(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local tb, bgb, l
        local text, bg, state = decorate_taglist(o)
        local interval = 0
        if state == "urgent" then
            interval = beautiful.taglist_blink_interval
        else
            interval = 0
        end

        if cache then
            tb = cache.tb
            bgb = cache.bgb
        else
            tb = dynamo.widget.label()
            bgb = wibox.widget.background()
            l = wibox.layout.fixed.horizontal()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(tb)

            -- And all of this gets a background
            bgb:set_widget(l)

            bgb:buttons(common.create_buttons(buttons, o))

            data[o] = {
                tb = tb,
                bgb = bgb,
            }
        end

        -- The text might be invalid, so use pcall
        if not pcall(tb.set_markup, tb, text) then
            tb:set_markup("<i>&lt;Invalid text&gt;</i>")
        end
        tb:set_color(bg, interval)
        w:add(bgb)
   end
end
-- }}}

-- {{{ Update the tasklist
local function decorate_tasklist(c)
    local theme = beautiful.get()
    local fg_normal = theme.tasklist_fg_normal or theme.fg_normal
    local bg_normal = theme.tasklist_bg_normal or theme.bg_normal
    local fg_focus = theme.tasklist_fg_focus or theme.fg_focus
    local bg_focus = theme.tasklist_bg_focus or theme.bg_focus
    local fg_urgent = theme.tasklist_fg_urgent or theme.fg_urgent
    local bg_urgent = theme.tasklist_bg_urgent or theme.bg_urgent
    local fg_minimize = theme.tasklist_fg_minimize or theme.fg_minimize
    local bg_minimize = theme.tasklist_bg_minimize or theme.bg_minimize
    local font = theme.tasklist_font or theme.font or ""
    local bg, fg = nil, nil
    local text = ""
    local name = c.name or "<untitled>"
    if client.focus == c then
        bg = bg_focus
        if fg_focus then
            fg = fg_focus
        else
            fg = fg_normal
        end
    elseif c.urgent and fg_urgent then
        bg = bg_urgent
        fg = fg_urgent
    elseif c.minimized and fg_minimize and bg_minimize then
        bg = bg_minimize
        fg = fg_minimize
    else
        bg = bg_normal
        fg = fg_normal
    end
    text = html.font(font, html(fg, util.escape(name)))

    return text, bg, c.icon or nil
end

dynamo.update_tasklist = function (w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local box
        local text, bg, icon = decorate_tasklist(o)

        if cache then
            box = cache.box
        else
            box = dynamo.widget.box()

            box:buttons(common.create_buttons(buttons, o))

            data[o] = {
                box = box
            }
        end

        -- The text might be invalid, so use pcall
        if not pcall(box.text.set_markup, box.text, text) then
            box.text:set_markup("<i>&lt;Invalid text&gt;</i>")
        end
        box:set_color(bg)
        box.image:set_image(icon)
        w:add(box)
   end
end
-- }}}
