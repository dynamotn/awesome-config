-- Widget library
local wibox = require('wibox')
local gears = require('gears')
-- Theme handling library
local beautiful = require('beautiful')
-- LGI library
local lgi = require('lgi')
local dpi = require('beautiful').xresources.apply_dpi

local bar = { mt = {} }

function bar:draw(context, cairo, width, height)
  cairo:save()
  if self._private.background then
    cairo:set_source(self._private.background)
  end
  cairo:arc(height / 2, height / 2, (height - beautiful.tasklist_margin_top) / 2, math.pi / 2, 3 * (math.pi / 2))
  cairo:arc(
    width - height / 2,
    height / 2,
    (height - beautiful.tasklist_margin_top) / 2,
    3 * (math.pi / 2),
    math.pi / 2
  )
  cairo:close_path()
  if self._private.background then
    cairo:fill()
  end
  if self._private.bgimage then
    cairo:clip()
    pattern = lgi.cairo.Pattern.create_for_surface(self._private.bgimage)
    lgi.cairo.Pattern.set_extend(pattern, lgi.cairo.Extend.REPEAT)
    cairo:set_source(pattern)
    cairo:paint()
  end
  cairo:restore()
end

function bar:before_draw_children(_, _, _, _) end

local function new(buttons, image)
  local background = wibox.container.background()
  local text = wibox.widget.textbox()
  background.text = text

  for k, v in pairs(bar) do
    if type(v) == 'function' then
      background[k] = v
    end
  end

  background:setup({
    widget = wibox.layout.fixed.horizontal(),
    bg = beautiful.tasklist_bg_normal,
    buttons = buttons,
    wibox.container.margin(image, dpi(4 + beautiful.bottom_panel_height / 2), dpi(0)),
    wibox.container.margin(text, dpi(4), dpi(4)),
  })

  return background
end

function bar.mt:__call(...)
  return new(...)
end

return setmetatable(bar, bar.mt)
