-- Widget library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Custom library
local separator = require('widgets.components').separator
local array_values = require('lib.array').array_values

-- { Create powerline section that includes: separator, child widget, internal textbox and fill color
-- @param number index Index of section, used for autogenerated color
-- @param string/table Icon path of section's widget or awesomeWM widget
-- @param string color_current Hexa or name color of this section
-- @param string color_next Hexa or name color of next section (left-to-right for index > 0, unless is right-to-left)
-- @return table Table with information of section
local function create(index, widget, color_current, color_next)
  local section = {
    id = index,
    layout = wibox.layout.fixed.horizontal,
  }

  -- Use separate variables to store attribute of section because may be conflict with declarative layout
  local direction
  local section_widget_type
  local section_widget
  local section_text
  local section_textbar
  local section_separator

  if index > 0 then
    direction = 'right'
  else
    direction = 'left'
  end
  if not color_current then
    color_current = array_values(beautiful.powerline_bgs, math.abs(index))
  end
  if not color_next then
    color_next = array_values(beautiful.powerline_bgs, math.abs(index) + 1)
  end
  section_separator = separator(beautiful.powerline_symbol, direction, 'solid', color_current, color_next)

  -- Preprocess widget before set background
  local function preprocess_widget(widget)
    if type(widget) == 'table' then
      section_widget_type = 'widget'
    elseif type(widget) == 'string' then
      widget = wibox.widget.imagebox(widget)
      section_widget_type = 'icon'
    end
    return widget
  end

  section_widget = wibox.container.background(preprocess_widget(widget), color_current)
  section_text = wibox.widget.textbox()
  section_textbar = wibox.container.background(section_text, color_current)

  function section:text()
    return section_text
  end

  function section:set_widget(widget)
    section_widget:set_widget(preprocess_widget(widget))
  end

  function section:set_markup(text)
    return section_text:set_markup((section_widget_type == 'icon' and '' or ' ') .. text .. ' ')
  end

  -- TODO: Hover exactly on arrow of powerline section

  if index > 0 then
    table.insert(section, section_widget)
    table.insert(section, section_textbar)
    table.insert(section, section_separator)
  else
    table.insert(section, section_separator)
    table.insert(section, section_widget)
    table.insert(section, section_textbar)
  end
  return section
end

-- }

return setmetatable({}, {
  __call = function(_, ...)
    return create(...)
  end,
})
