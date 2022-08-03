-- AwesomeWM standard library
local awful = require('awful')

return {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
}
