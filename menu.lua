-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}

require("freedesktop")

freedesktop.utils.terminal   = terminal
freedesktop.utils.icon_theme = beautiful.icon_theme

menu_items = freedesktop.menu.new()

myawesomemenu = {
    { "Sửa &cấu hình", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", beautiful.menu_edit_icon },
    { "&Khởi tạo lại", awesome.restart, beautiful.menu_refresh_icon },
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

mymainmenu = awful.menu.new({ items = menu_items, theme = { width = beautiful.menu_width, height = beautiful.menu_height } })
mylauncher = awful.widget.launcher({ image = beautiful.tux, menu = mymainmenu })
