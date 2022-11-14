-- AwesomeWM standard library
local ruled = require('ruled')
-- Notification library
local naughty = require('naughty')
-- Rules
local rules = require('rules')

naughty.connect_signal('request::display', function(n)
  naughty.layout.box({ notification = n })
end)

ruled.notification.connect_signal('request::rules', function()
  ruled.notification.append_rule(rules.notification)
end)
