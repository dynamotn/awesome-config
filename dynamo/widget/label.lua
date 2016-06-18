-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Widget library
local textbox = require("wibox.widget.textbox")
local gears = require("gears")
local beautiful = require("beautiful")
-- Pango library
local Pango = require("lgi").Pango

local label = { mt = {} }

-- Setup a pango layout for the given textbox and cairo context
local function setup_layout(label, width, height)
    local layout = label._layout
    layout.width = Pango.units_from_double(width)
    layout.height = Pango.units_from_double(height)
end

--- No-op, accept whatever background is drawn
function label:draw(wibox, cairo, width, height)
    -- Layout config
    cairo:update_layout(self._layout)
    setup_layout(self, width, height)
    cairo:save()

    -- Make label cairo
    cairo:set_source_rgb(gears.color.parse_color(self.color))
    cairo:new_path()
    cairo:move_to(beautiful.taglist_margin_left / 2, beautiful.taglist_margin_top / 2)
    cairo:line_to(beautiful.taglist_margin_left / 2, height - beautiful.taglist_margin_top / 2 - beautiful.taglist_small_corner)
    cairo:line_to(beautiful.taglist_margin_left / 2 + beautiful.taglist_small_corner, height - beautiful.taglist_margin_top / 2)
    cairo:line_to(width - beautiful.taglist_margin_left / 2, height - beautiful.taglist_margin_top / 2)
    cairo:line_to(width - beautiful.taglist_margin_left / 2, beautiful.taglist_margin_top / 2 + beautiful.taglist_large_corner)
    cairo:line_to(width - beautiful.taglist_margin_left / 2 - beautiful.taglist_large_corner, beautiful.taglist_margin_top / 2)
    cairo:close_path()
    cairo:fill()

    -- Show text
    cairo:restore()
    local ink, logical = self._layout:get_pixel_extents()
    local offset = (height - logical.height) / 2
    cairo:move_to(beautiful.taglist_margin_left / 2 + beautiful.taglist_large_corner, offset)
    cairo:show_layout(self._layout)
end

function label:fit(width, height)
    setup_layout(self, width, height)
    local ink, logical = self._layout:get_pixel_extents()

    if logical.width == 0 or logical.height == 0 then
        return 0, 0
    end

    return logical.width + beautiful.taglist_margin_left + 2 * beautiful.taglist_large_corner, logical.height + beautiful.taglist_margin_top
end

-- Change label cairo color
function label:set_color(color, blink_interval)
    self.color = color or beautiful.taglist_bg_empty
    self.blink_interval = blink_interval or 0

    if self.blink_interval ~= 0 and self.blink_timer == nil then
        self.value = 1
        self.blink_timer = timer { timeout = self.blink_interval }
        self.blink_timer:connect_signal("timeout", function()
            self.blink_timer:stop()
            self.blink_timer.timeout = self.blink_interval
            self.blink_timer:start()
            if self.value == 0 then
                self.value = 1 
                self.color = beautiful.taglist_bg_empty
            else
                self.value = 0 
                self.color = color or beautiful.taglist_bg_empty
            end
            self:emit_signal("widget::updated")
        end)
        self.blink_timer:start()
    elseif self.blink_interval == 0 and self.blink_timer ~= nil then
        self.blink_timer:stop()
    end
    self:emit_signal("widget::updated")
end

local function new(color, blink_interval)
    local ret = textbox()
    ret.color = color or beautiful.taglist_bg_empty
    ret.blink_interval = blink_interval or 0

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
