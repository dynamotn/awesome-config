-- AwesomeWM standard library
local beautiful = require('beautiful')

return {
  rule = {},
  properties = {
    ontop = true,
    timeout = 3,
    position = beautiful.notification_position,
    bg = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    spacing = beautiful.notification_spacing,
    icon_size = beautiful.notification_icon_size,
  },
}
