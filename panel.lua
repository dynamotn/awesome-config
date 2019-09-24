-- AwesomeWM standard library
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")

-- Keyboard map indicator and switcher
dynamo_keyboard_layout = awful.widget.keyboardlayout()

-- Create a textclock widget
dynamo_text_clock = wibox.widget.textclock()
