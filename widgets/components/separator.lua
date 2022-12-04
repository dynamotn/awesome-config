-- Widget and gears library
local wibox = require('wibox')
local gears = require('gears')

local chevron_size = 1

-- { Draw arrow with cairo
-- @param lgi.cairo cairo 2D graphic library
-- @param number width Width of separator
-- @param number height Height of separator
-- @param string direction 'left' or 'right' direction
-- @param string style 'solid' or 'chevron' style
-- @param string fg_color Hexa or name foreground color of separator
-- @param string bg_color Hexa or name background color of separator
local function draw_arrow(cairo, width, height, direction, style, fg_color, bg_color)
  if not style or not direction then
    return
  end

  local triangle_apex_x
  local triangle_apex_vicinity_x
  local triangle_base_x
  local triangle_base_vicinity_x

  if direction == 'right' then
    triangle_apex_x = width
    triangle_apex_vicinity_x = width - chevron_size
    triangle_base_x = 0
    triangle_base_vicinity_x = chevron_size
  elseif direction == 'left' then
    triangle_apex_x = 0
    triangle_apex_vicinity_x = chevron_size
    triangle_base_x = width
    triangle_base_vicinity_x = width - chevron_size
  end

  cairo:set_source_rgba(gears.color.parse_color(fg_color))
  cairo:new_path()
  if style == 'solid' then
    cairo:move_to(triangle_base_x, 0)
    cairo:line_to(triangle_apex_x, height / 2)
    cairo:line_to(triangle_base_x, height)
  elseif style == 'chevron' then
    cairo:move_to(triangle_base_x, 0)
    cairo:line_to(triangle_base_vicinity_x, 0)
    cairo:line_to(triangle_apex_x, height / 2 - chevron_size)
    cairo:line_to(triangle_apex_x, height / 2 + chevron_size)
    cairo:line_to(triangle_base_vicinity_x, height)
    cairo:line_to(triangle_base_x, height)
    cairo:line_to(triangle_base_x, height - chevron_size)
    cairo:line_to(triangle_apex_vicinity_x, height / 2)
    cairo:line_to(triangle_base_x, chevron_size)
  end
  cairo:close_path()
  cairo:fill()

  if bg_color ~= 'opaque' then
    cairo:set_source_rgba(gears.color.parse_color(bg_color))
  end
  cairo:new_path()
  if style == 'solid' then
    cairo:move_to(triangle_base_x, 0)
    cairo:line_to(triangle_apex_x, height / 2)
    cairo:line_to(triangle_base_x, height)
    cairo:line_to(triangle_apex_x, height)
    cairo:line_to(triangle_apex_x, 0)
    cairo:close_path()
  elseif style == 'chevron' then
    -- TODO: background for left and right of chevron
  end
  cairo:close_path()
  cairo:fill()
end

-- }

-- { Draw curve with cairo
-- @param lgi.cairo cairo 2D graphic library
-- @param number width Width of separator
-- @param number height Height of separator
-- @param string direction 'left' or 'right' direction
-- @param string style 'solid' or 'chevron' style
-- @param string fg_color Hexa or name foreground color of separator
-- @param string bg_color Hexa or name foreground color of separator
local function draw_curve(cairo, width, height, direction, style, fg_color, bg_color)
  local curve_center_x
  if direction == 'left' then
    curve_center_x = width
    start_angle = math.pi / 2
    end_angle = 3 * math.pi / 2
  else
    curve_center_x = 0
    start_angle = -math.pi / 2
    end_angle = math.pi / 2
  end

  cairo:set_source_rgb(gears.color.parse_color(fg_color))
  cairo:arc(curve_center_x, height / 2, height / 2, start_angle, end_angle)
  cairo:fill()

  if style == 'chevron' then
    cairo:set_source_rgb(gears.color.parse_color(bg_color))
    cairo:arc(curve_center_x, height / 2, height / 2 - chevron_size, start_angle, end_angle)
    cairo:fill()
  end
end

-- }

-- { Create separator widget same as powerline symbol
-- @param string symbol 'arrow' or 'curve'
-- @param string direction 'left' or 'right' direction
-- @param string style 'solid' or 'chevron' style
-- @param string fg_color Hexa or name foreground color of separator or 'opaque'
-- @param string bg_color Hexa or name background color of separator or 'opaque'
-- @return table Widget with shape same as powerline arrow
local function create(symbol, direction, style, fg_color, bg_color)
  if symbol ~= 'arrow' and symbol ~= 'curve' then
    return
  end
  if direction ~= 'left' and direction ~= 'right' then
    return
  end
  if style ~= 'solid' and style ~= 'chevron' then
    return
  end

  return {
    layout = wibox.widget.base.make_widget,
    fit = function(_, _, width, height)
      -- Get width and height same with base widget that current widget put on
      return height / 2, height
    end,
    draw = function(_, _, cairo, width, height)
      if fg_color ~= 'opaque' then
        if symbol == 'arrow' then
          draw_arrow(cairo, width, height, direction, style, fg_color, bg_color)
        elseif symbol == 'curve' then
          draw_curve(cairo, width, height, direction, style, fg_color, bg_color)
        end
      end
    end,
  }
end

-- }

return setmetatable({}, {
  __call = function(_, ...)
    return create(...)
  end,
})
