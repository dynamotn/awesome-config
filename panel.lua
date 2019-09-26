-- AwesomeWM standard library
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local dynamo = require("dynamo")

-- Powerline prompt
dynamo_powerline_prompt_box = dynamo.widget.separator("arrow", "left", "chevron", beautiful.prompt_bg_normal, beautiful.fg_urgent)

-- Keyboard map indicator and switcher
dynamo_keyboard_layout = awful.widget.keyboardlayout()

-- Create a textclock widget
dynamo_text_clock = wibox.widget.textclock()
