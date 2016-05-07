-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Standard awesome library
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Theme handling library
beautiful = require("beautiful")
-- }}}

-- {{{ Other library
-- Redshift library
redshift = require("redshift")
-- Layout library
layout = require("layout")
-- Error handling, variable definitions and function definitions
require("helpers")
require("dynamo")
-- }}}

-- {{{ Autostart applications
require_exist("autorun")
-- }}}

-- {{{ Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/themes/theme.lua")
-- }}}

-- {{{ Wallpaper
-- Auto change wallpaper after wp_timeout second(s)
wp_files = scandir(wp_path, wp_filter)
if next(wp_files) ~= nil then
    wp_timer = timer { timeout = 0 }
    wp_timer:connect_signal("timeout", function()
        wp_timer:stop()
        wp_timer.timeout = wp_timeout
        wp_timer:start()
        for s = 1, screen.count() do
            wp_index = math.random(1, #wp_files)
            gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
        end
        collectgarbage("collect")
    end)
    wp_timer:start()
end
-- }}}

-- {{{ Redshift config
redshift.redshift = "/sbin/redshift"
redshift.toggle()
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
