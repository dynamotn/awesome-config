-- AwesomeWM standard library
local ruled = require('ruled')
-- Notification library
local naughty = require('naughty')
-- Rules
local rules = require('rules')

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal('request::display_error', function(message, startup)
  naughty.notification({
    urgency = 'critical',
    title = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
    message = message,
  })
end)

naughty.connect_signal('request::display', function(n)
  naughty.layout.box({ notification = n })
end)

ruled.notification.connect_signal('request::rules', function()
  ruled.notification.append_rule(rules.notification)
end)
