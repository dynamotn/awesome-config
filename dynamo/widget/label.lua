-- Widget library
local textbox = require("wibox.widget.textbox")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")
-- Pango library
local Pango = require("lgi").Pango

local label = { mt = {} }

-- Setup a pango layout for the given textbox and cairo context
local function setup_layout(label, width, height, dpi)
  local layout = label._private.layout
  layout.width = Pango.units_from_double(width)
  layout.height = Pango.units_from_double(height)
  if label._private.dpi ~= dpi then
    label._private.ctx:set_resolution(dpi)
    label._private.layout:context_changed()
  end
end

--- No-op, accept whatever background is drawn
function label:draw(context, cairo, width, height)
  -- Layout config
  setup_layout(self, width, height, context.dpi)
  cairo:update_layout(self._private.layout)
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
  local ink, logical = self._private.layout:get_pixel_extents()
  local offset = (height - logical.height) / 2
  cairo:move_to(beautiful.taglist_margin_left / 2 + beautiful.taglist_large_corner, offset)
  cairo:show_layout(self._private.layout)
end

function label:fit(context, width, height)
  setup_layout(self, width, height, context.dpi)
  local ink, logical = self._private.layout:get_pixel_extents()

  if logical.width == 0 or logical.height == 0 then
    return 0, 0
  end

  return logical.width + beautiful.taglist_margin_left + 2 * beautiful.taglist_large_corner, logical.height + beautiful.taglist_margin_top
end

-- Change label cairo color
function label:set_color(color, blink_interval)
  self.color = color or beautiful.taglist_bg_empty
  self.blink_interval = blink_interval or 0

  if self.blink_interval ~= 0 and (self.blink_timer == nil or not self.blink_timer.started) then
    self.value = 1
    self.blink_timer = gears.timer { timeout = self.blink_interval }
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
  elseif self.blink_interval == 0 and self.blink_timer ~= nil and self.blink_timer.started then
    self.blink_timer:stop()
  end
  self:emit_signal("widget::updated")
end

local function create(color, blink_interval)
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
  return create(...)
end

return setmetatable(label, label.mt)
