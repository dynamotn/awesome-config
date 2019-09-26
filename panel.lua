-- AwesomeWM standard library
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local dynamo = require("dynamo")
local vicious = require("vicious")

-- { Left panel
local panel_index = 0

panel_index = panel_index + 1
-- Menu button
dynamo_launcher_section = wibox.container.background(dynamo_launcher, beautiful.prompt_bg_normal)
-- Powerline prompt
dynamo_prompt_section = dynamo.bar.powerline_section(panel_index, nil, beautiful.prompt_bg_normal, "opaque")
vicious.register(dynamo_prompt_section.text, vicious.widgets.os, dynamo.string.markup_text(" $3@$4", beautiful.prompt_fg_normal))
-- }

-- { Right panel
-- Keyboard map indicator and switcher
dynamo_keyboard_layout = awful.widget.keyboardlayout()

-- Create a textclock widget
dynamo_text_clock = wibox.widget.textclock()
-- }

-- { Miscellaneous
space = wibox.widget.textbox(' ')
-- }
