-- AwesomeWM standard library
local awful = require("awful")
-- Widget library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local powerline_section = require("dynamo.bar").powerline_section
local markup_text = require("dynamo.string").markup_text
local vicious = require("vicious")

-- { Left panel
local panel_index = 0

-- Menu button
dynamo_launcher = wibox.container.background(launcher, beautiful.prompt_bg_normal)

-- Powerline prompt
panel_index = panel_index + 1
dynamo_prompt = powerline_section(
  panel_index,
  dynamo_launcher,
  beautiful.prompt_bg_normal,
  "opaque"
)
vicious.register(
  dynamo_prompt,
  vicious.widgets.os,
  markup_text("$3@$4", beautiful.prompt_fg_normal)
)
-- }

-- { Right panel
local panel_index = -1

-- Layout button
dynamo_layout = function(screen)
  local panel_index = -1
  return powerline_section(panel_index, awful.widget.layoutbox(screen), beautiful.layout_bg_normal)
end

-- Clock
panel_index = panel_index - 1
dynamo_clock = powerline_section(panel_index)
vicious.register(
  dynamo_clock,
  vicious.widgets.date,
  markup_text("%I:%M %p ", beautiful.clock_fg_hour) .. markup_text("%a %d %b", beautiful.clock_fg_date),
  10
)

-- Keyboard map indicator and switcher
panel_index = panel_index - 1
dynamo_keyboard = powerline_section(panel_index, awful.widget.keyboardlayout(), nil, "opaque")
-- }

-- { Miscellaneous
space = wibox.widget.textbox(' ')
-- }
