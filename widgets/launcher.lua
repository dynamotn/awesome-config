-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
local menu = require('widgets.menu')

return awful.widget.launcher({ image = beautiful.launcher_icon, menu = menu })
