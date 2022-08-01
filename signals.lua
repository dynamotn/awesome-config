-- AwesomeWM standard library
local awful = require('awful')
local gears = require('gears')
-- Widget library
local wibox = require('wibox')
require('awful.autofocus')
-- Theme handling library
local beautiful = require('beautiful')
-- Custom library
local misc = require('dynamo.misc')

-- { Client signal
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
  c.shape = function(cairo, width, height)
    gears.shape.rounded_rect(cairo, width, height, beautiful.border_radius)
  end

  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_normal
end)
-- }

-- { Screen signal
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', misc.auto_change_wallpaper)
screen.connect_signal('added', awesome.restart)
screen.connect_signal('removed', awesome.restart)
-- }
