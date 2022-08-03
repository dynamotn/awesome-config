-- AwesomeWM standard library
local awful = require('awful')

return {
  rule = {},
  properties = {
    screen = awful.screen.preferred,
    implicit_timeout = 3,
  },
}
