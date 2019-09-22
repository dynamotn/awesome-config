-- { Theme config location
local gears = require("gears")
theme_location = gears.filesystem.get_themes_dir() .. "default/theme.lua"
-- }

-- { Shell helper
-- If current shell is fish then use not POSIX syntax
is_fish_shell = string.find(os.getenv("SHELL"), "fish")

-- Some strings in command line
local and_operator = is_fish_shell and "; and " or " && "
local or_operator = is_fish_shell and "; or " or " || "
local space = " "
local command_option = " -c "

-- Default application
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
browser = "firefox"

-- Terminal command
tmux = "'" .. "tmux -q has-session" .. and_operator .. "exec tmux attach-session -d" .. or_operator .. "exec tmux new-session -nwtf -s$USER@$HOSTNAME" .. "'"

editor_cmd = terminal .. space .. editor
terminal_tmux = terminal .. space .. os.getenv("SHELL") .. command_option .. tmux
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
