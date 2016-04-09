local awful     = require("awful")
local beautiful = require("beautiful")

require("freedesktop")
require("freedesktop.utils")

freedesktop.utils.terminal   = terminal
freedesktop.utils.icon_theme = 'Moka'

menu_items = freedesktop.menu.new()

myawesomemenu = {
 { "Sửa cấu hình", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
 { "Khởi tạo lại", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
 { "Thoát phiên", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
}

table.insert(menu_items, { "Awesome", myawesomemenu, beautiful.awesome_icon })

mymainmenu = awful.menu.new({ items = menu_items, theme = { width = 150 } })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
