-- { Localization
os.setlocale(os.getenv("LANG"))
-- }

-- { Reconfigure notification
local naughty = require("naughty")
naughty.config.defaults.timeout = 10
-- }

-- { Initial theme
local beautiful = require("beautiful")
beautiful.init(theme_location)
-- }

-- { Setup layouts
local awful = require("awful")
awful.layout.layouts = layouts
-- }

-- { Reconfigure menubar
local menubar = require("menubar")
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }
