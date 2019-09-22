-- { Theme config location
local gears = require("gears")
theme_location = gears.filesystem.get_themes_dir() .. "default/theme.lua"
-- }

-- { Default application
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. editor
-- }

-- { Default functional key
modkey = "Mod4"
altkey = "Mod1"
-- }

-- { List layouts
local awful = require("awful")
layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
}
-- }

-- { Launcher, panel
-- Workspace
workspaces = { "TERM", "WEB", "CODE", "M&V", "CHAT", "DOC", "GAME", "SYS", "MORE" }
-- }
