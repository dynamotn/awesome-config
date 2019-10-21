-- { Theme config location
local awful = require("awful")
theme_location = awful.util.getdir("config") .. "/theme/theme.lua"
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
clipboard = "copyq"
clipboard_list = clipboard .. " menu"

-- Terminal command
tmux = "'" .. "tmux -q has-session" .. and_operator .. "exec tmux attach-session -d" .. or_operator .. "exec tmux new-session -nwtf -s$USER@$HOSTNAME" .. "'"

editor_cmd = terminal .. space .. editor
terminal_tmux = terminal .. space .. os.getenv("SHELL") .. command_option .. tmux

-- Get Linux distribution name
local misc = require("dynamo.misc")
linux_distribution = misc.linux_distribution()
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
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
}
-- }

-- { Launcher, panel
-- Workspace
workspaces = { "TERM", "WEB", "CODE", "M&V", "CHAT", "DOC", "GAME", "SYS", "MORE" }
-- }

-- { Wallpaper auto change config
local filesystem = require("dynamo.filesystem")
local gears = require("gears")
wallpaper = {
  files = filesystem.scan_dir_by_mime(filesystem.xdg_user_dirs("PICTURES") .. "/Wallpaper", "image"),
  timer = gears.timer { timeout = 10 },
}
-- }

-- { Popup config
number_of_processes = 25
-- }
