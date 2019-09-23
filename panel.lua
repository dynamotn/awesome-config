-- AwesomeWM standard library
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()
