-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget library
local textbox = require("wibox.widget.textbox")
local gears = require("gears")
local beautiful = require("beautiful")
-- Pango library
local lgi = require("lgi")
local Pango = lgi.Pango

local label = { mt = {} }

-- Setup a pango layout for the given textbox and cairo context
local function setup_layout(box, width, height)
    local layout = box._layout
    layout.width = Pango.units_from_double(width)
    layout.height = Pango.units_from_double(height)
end

--- No-op, accept whatever background is drawn
function label:draw(wibox, cairo, width, height)
    cairo:update_layout(self._layout)
    setup_layout(self, width, height)
    local ink, logical = self._layout:get_pixel_extents()
    local offset = (height - logical.height) / 2
    cairo:move_to(border_width, offset)
    cairo:show_layout(self._layout)
end

function label:fit(width, height)
    setup_layout(self, width, height)
    local ink, logical = self._layout:get_pixel_extents()

    if logical.width == 0 or logical.height == 0 then
        return 0, 0
    end

    return logical.width, logical.height
end

local function new()
    local ret = textbox()

    for k, v in pairs(label) do
        if type(v) == "function" then
            ret[k] = v
        end
    end

    return ret
end

function label.mt:__call(...)
    return new(...)
end

return setmetatable(label, label.mt)
