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
clipboard = "greenclip daemon"
music = "ncmpcpp"
music_control = "mpc"
sound_control = "pactl"
email_client = "neomutt"
launcher = "rofi"
launcher_application = launcher .. space .. "-show drun"
launcher_command = launcher .. space .. "-show run"
clipboard_list = launcher .. " -modi 'clipboard:greenclip print' -show clipboard" .. and_operator .. "xdotool key Shift+Insert"

-- Terminal command
tmux = "'" .. "tmux -q has-session" .. and_operator .. "exec tmux attach-session -d" .. or_operator .. "exec tmux new-session -nwtf -s$USER@$HOSTNAME" .. "'"

editor_cmd = terminal .. space .. editor
music_cmd = terminal .. space .. music
email_cmd = terminal .. space .. email_client
terminal_tmux = terminal .. space .. os.getenv("SHELL") .. command_option .. tmux

music_play_cmd = music_control .. space .. "toggle"
music_pause_cmd = music_control .. space .. "pause"
music_stop_cmd = music_control .. space .. "stop"
music_next_cmd = music_control .. space .. "next"
music_previous_cmd = music_control .. space .. "prev"
volume_raise_cmd = sound_control .. space .. "set-sink-volume @DEFAULT_SINK@ +1%"
volume_lower_cmd = sound_control .. space .. "set-sink-volume @DEFAULT_SINK@ -1%"
volume_mute_cmd = sound_control .. space .. "set-sink-mute @DEFAULT_SINK@ toggle"

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
term_workspace = "TERM"
web_workspace = "WEB"
mail_workspace = "MAIL"
music_workspace = "M&V"
chat_workspace = "CHAT"
doc_workspace = "DOC"
game_workspace = "GAME"
sys_workspace = "SYS"
other_workspace = "MORE"
workspaces = {
  term_workspace,
  web_workspace,
  mail_workspace,
  music_workspace,
  chat_workspace,
  doc_workspace,
  game_workspace,
  sys_workspace,
  other_workspace,
}
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
