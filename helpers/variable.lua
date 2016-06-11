-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Localization
os.setlocale(os.getenv("LANG"))
-- }}}

-- {{{ If current shell is fish then use not POSIX syntax
is_fish_shell = string.find(os.getenv("SHELL"), "fish")
-- }}}

-- {{{ Default application
terminal        = "urxvtc"
if is_fish_shell then 
    tmux = " -e fish -c 'tmux -q has-session; and exec tmux attach-session -d; or exec tmux new-session -nwtf -s$USER@$HOSTNAME'"
else
    tmux = " -e sh -c 'tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -nwtf -s$USER@$HOSTNAME'"
end
screenshot      = "scrot"
file_manager    = "nautilus"
browser         = "firefox"
editor          = os.getenv("EDITOR") or "vim"
editor_cmd      = terminal .. " -e " .. editor
terminal_cmd    = terminal .. " -g 130x34-320+16 -e "
terminal_tmux   = terminal .. tmux
music_cmd       = terminal_cmd .. "ncmpcpp"
monitor_cmd     = terminal_cmd .. "htop"
-- }}}

-- {{{ Default function key on keyboard
modkey = "Mod4"
altkey = "Mod1"
-- }}}

-- {{{ Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    layout.centerworkd,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper auto change config
wp_index   = 1
wp_timeout = 10
wp_path    = trim(awful.util.pread("xdg-user-dir PICTURES")) .. "/Wallpaper/"
wp_filter  = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
-- }}}

-- {{{ Default launcher, panel
-- Launcher
mylauncher = awful.widget.launcher({ menu = {} })

-- Workspace
tags = {
    names = { "TERM", "WEB", "CODE", "M&V", "CHAT", "DOC", "GAME", "SYS", "MORE"},
    layout = { layouts[3], layouts[2], layouts[5], layouts[1], layouts[3], layouts[4], layouts[3], layouts[4], layouts[5]}
}

-- Panel
mywibox       = {}
mybottomwibox = {}
mypromptbox   = {}
mylayoutbox   = {}
mytaglist     = {}
mytasklist    = {}
-- }}}

-- {{{ Default config for notify
local naughty = require('naughty')
naughty.config.defaults.timeout = 10
naughty.config.defaults.screen = screen.count()
-- }}}
