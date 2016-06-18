-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget library
local wibox = require("wibox")
local base = require("wibox.widget.base")
local gears = require("gears")
local beautiful = require("beautiful")
-- Pango library
local cairo = require("lgi").cairo

local calendar = { mt = {} }

function calendar:draw(wibox, cr, width, height)
end

function calendar:fit(width, height)
    return 20, 10
end

local function new(color)
    local panel = base.make_widget()

    for k, v in pairs(calendar) do
        if type(v) == "function" then
            panel[k] = v
        end
    end

    return panel
end

function calendar.mt:__call(...)
    return new(...)
end

return setmetatable(calendar, calendar.mt)
