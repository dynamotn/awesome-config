-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Standard awesome library
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Menubar
local menubar = require("menubar")
-- Theme handling library
beautiful = require("beautiful")
-- }}}

-- {{{ Other library
-- Redshift library
redshift = require("redshift")
-- Error handling, variable definitions and function definitions
require("helpers")
-- }}}

-- {{{ Autostart applications
require_exist("autorun")
-- }}}

-- {{{ Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/theme.lua")
-- }}}

-- {{{ Wallpaper
-- Auto change wallpaper after wp_timeout second(s)
wp_files = scandir(wp_path, wp_filter)
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()
    for s = 1, screen.count() do
        gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
    end
    collectgarbage("collect")
    wp_timer:stop()
    wp_index = math.random(1, #wp_files)
    wp_timer.timeout = wp_timeout
    wp_timer:start()
end)
wp_timer:start()
-- }}}

-- {{{ Redshift config
redshift.redshift = "/sbin/redshift"
-- }}}

-- {{{ Tags
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
require_exist("menu")
-- }}}

-- {{{ Init basic config
-- Mouse bindings
require("mouse")

-- Panel
require("panel")

-- Key bindings
require("keyboard")

-- Rules
require("rule")

-- Signals
require("signal")
-- }}}
