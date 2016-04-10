-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Localization
os.setlocale(os.getenv("LANG"))

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default function key on keyboard
modkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.magnifier
}

-- If current shell is fish then use not POSIX syntax
is_fish_shell = string.find(os.getenv("SHELL"), "fish")

-- Wallpaper auto change config
wp_index = 1
wp_timeout = 10
wp_path = trim(awful.util.pread("xdg-user-dir PICTURES")) .. "/Wallpaper/"
wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
