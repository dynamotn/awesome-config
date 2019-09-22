-- { Localization
os.setlocale(os.getenv("LANG"))
-- }

-- { Reconfigure notification
local naughty = require("naughty")
naughty.config.defaults.timeout = 10
naughty.config.defaults.screen = screen.count()
-- }

-- { Initial theme
local beautiful = require("beautiful")
beautiful.init(theme_location)
-- }

-- { Setup layouts
local awful = require("awful")
awful.layout.layouts = layouts
-- }
