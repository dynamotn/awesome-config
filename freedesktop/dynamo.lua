-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
local awful     = require("awful")
local beautiful = require("beautiful")

require("freedesktop")
require("helpers.system")
require("freedesktop.utils")

freedesktop.utils.terminal   = terminal
freedesktop.utils.icon_theme = 'Moka'

menu_items = freedesktop.menu.new()

myawesomemenu = {
    { "Sửa &cấu hình", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
    { "&Khởi tạo lại", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
}

mysystemmenu = {
    { "&Khóa màn hình", dynamo.lock, freedesktop.utils.lookup_icon({ icon = 'system-lock-screen' })},
    { "Thoát &phiên", dynamo.quit, freedesktop.utils.lookup_icon({ icon = 'system-log-out' }) },
    { "&Ngủ đông", dynamo.hibernate, freedesktop.utils.lookup_icon({ icon = 'system-hibernate' })},
    { "Khởi động &lại", dynamo.reboot, freedesktop.utils.lookup_icon({ icon = 'system-reboot' })},
    { "&Tắt máy", dynamo.shutdown, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' })},
    { "&Hẹn giờ tắt máy", dynamo.shutdown_schedule, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' })},
}

table.insert(menu_items, { "&Awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "&Hệ thống", mysystemmenu, freedesktop.utils.lookup_icon({ icon = 'system' }) })

mymainmenu = awful.menu.new({ items = menu_items, theme = { width = 200, height = 24 } })
mylauncher = awful.widget.launcher({ image = beautiful.tux, menu = mymainmenu })
