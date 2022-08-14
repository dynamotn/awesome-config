-- AwesomeWM standard library
local awful = require('awful')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Widgets
local widgets = require('widgets')

screen.connect_signal('request::desktop_decoration', function(s)
  -- Create lockscreen
  s.lockscreen = awful.wibar({
    screen = s,
    visible = false,
    ontop = true,
    type = 'splash',
    width = s.geometry.width,
    height = s.geometry.height,
  })

  s.input_password_box = awful.widget.prompt({
    prompt = '',
  })
  s.warning_text = wibox.widget.textbox()

  s.lockscreen:setup({
    layout = wibox.layout.fixed.vertical,
    s.input_password_box,
    s.warning_text,
  })
end)
