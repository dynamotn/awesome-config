-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget library
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
-- Pango library
local cairo = require("lgi").cairo
local math = math

local box = { mt = {} }

function box:draw(wibox, cr, width, height)
    cr:save()
    if string.match(self.color, "[#].") then
        cr:set_source_rgb(gears.color.parse_color(self.color))
    end
    cr:arc(height / 2, height / 2, (height - beautiful.tasklist_margin_top) / 2, math.pi / 2, 3 * (math.pi / 2))
    cr:arc(width - height / 2, height / 2, (height - beautiful.tasklist_margin_top) / 2, 3 * (math.pi / 2), math.pi / 2)
    cr:close_path()
    if string.match(self.color, "[#].") then
        cr:fill()
    else
        cr:clip()
        image = cairo.ImageSurface.create_from_png(self.color)
        pattern = cairo.Pattern.create_for_surface(image)
        cairo.Pattern.set_extend(pattern, cairo.Extend.REPEAT)
        cr:set_source(pattern)
        cr:paint()
    end
    cr:restore()
    self:_draw(wibox, cr, width, height)
end

local function new(color)
    local text = wibox.widget.textbox()
    local image = wibox.widget.imagebox()
    local layout = wibox.layout.fixed.horizontal()
    local background = wibox.widget.background()
    local margin_text = wibox.layout.margin(text, 4, 4)
    local margin_image = wibox.layout.margin(image, 4 + beautiful.bottom_panel_height / 2, 0)
    background.color = color or beautiful.tasklist_bg_normal

    background._draw = background.draw

    for k, v in pairs(box) do
        if type(v) == "function" then
            background[k] = v
        end
    end

    -- All of this is added in a fixed widget
    layout:fill_space(true)
    layout:add(margin_image)
    layout:add(margin_text)
    -- And all of this gets a background
    background:set_widget(layout)

    background.image = image
    background.text = text

    return background 
end

function box:set_color(color)
    self.color = color or beautiful.tasklist_bg_normal
    self._emit_updated()
end

function box.mt:__call(...)
    return new(...)
end

return setmetatable(box, box.mt)
