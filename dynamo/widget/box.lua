-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget library
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
-- Pango library
local lgi = require("lgi")
local cairo = require("lgi").cairo

local box = { mt = {} }

function box:draw(wibox, cr, width, height)
    self:_draw(wibox, cr, width, height)
end

local function new()
    local text = wibox.widget.textbox()
    local image = wibox.widget.imagebox()
    local layout = wibox.layout.fixed.horizontal()
    local margin = wibox.layout.margin(text, 4, 4)
    local background = wibox.widget.background()

    background._draw = background.draw

    for k, v in pairs(box) do
        if type(v) == "function" then
            background[k] = v
        end
    end

    -- All of this is added in a fixed widget
    layout:fill_space(true)
    layout:add(image)
    layout:add(margin)
    -- And all of this gets a background
    background:set_widget(layout)

    background.image = image
    background.text = text

    return background 
end

function box.mt:__call(...)
    return new(...)
end

return setmetatable(box, box.mt)
