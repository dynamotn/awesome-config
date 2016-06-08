-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
util = require("awful.util")
theme = {}
themes_dir = util.getdir("config") .. "/themes"

theme.font            = "Terminess Powerline 9"
theme.tasklist_font   = "Ubuntu Regular 9"

-- {{{ Color
theme.bg_normal     = "#1a1a1a"
theme.bg_focus      = "#313131"
theme.bg_urgent     = "#212121"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ddddff"
theme.fg_focus      = "#f0dfaf"
theme.fg_urgent     = "#33b5e5"

theme.border_normal = "#3f3f3f"
theme.border_focus  = "#7f7f7f"
theme.border_marked = "#cc9393"

-- Prompt color
theme.bg_command    = "#f0f0f0"

theme.fg_confirm    = "#4caf50"
theme.fg_command    = "#2196f3"

-- Widget color
theme.bg_widget     = { "#0c273d",
                        "#44c0dd",
                        "#f0f0f0",
                        "#70b85d",
                        "#2c5e2e" }
theme.bg_indicator  = { "#313131", theme.bg_normal}

theme.fg_widget     = { "#f3f3ff",
                        "#f3f3ff",
                        "#c44c51",
                        "#f3fff3",
                        "#f3fff3" }
theme.fg_hour       = theme.bg_widget[3]
theme.fg_date       = theme.bg_widget[1]
theme.fg_artist     = "#ea6f81"
theme.fg_net_down   = theme.bg_widget[2]
theme.fg_net_up     = theme.bg_widget[4]

-- Panel color
theme.taglist_bg_empty     = "#313131"
theme.taglist_bg_focus     = "#45aacc"
theme.taglist_bg_urgent    = "#45bf55"
theme.taglist_fg_focus     = "#fff3f3"
theme.taglist_fg_occupied  = "#acacac"
theme.taglist_fg_empty     = "#1a1a1a"
theme.taglist_fg_urgent    = "#fff3f3"
theme.tasklist_bg_normal   = themes_dir .. '/background/gray.png'
theme.tasklist_bg_minimize = themes_dir .. '/background/black.png'
theme.tasklist_bg_focus    = themes_dir .. '/background/white.png'
theme.tasklist_bg_urgent   = themes_dir .. '/background/blue.png'
theme.tasklist_fg_normal   = "#fff3f3"
theme.tasklist_fg_minimize = "#777e76"
theme.tasklist_fg_focus    = "#212121"
theme.tasklist_fg_urgent   = "#f0f0f0"

-- Notify color
theme.notify_fg     = theme.fg_normal
theme.notify_bg     = theme.bg_normal
theme.notify_border = theme.border_focus
-- }}}

-- {{{ Theming client
theme.border_width  = 1
theme.useless_gap_width = 10
-- }}}

-- {{{ Theming workspace 
theme.taglist_margin_left    = 3
theme.taglist_margin_top     = 8
theme.taglist_small_corner   = 2
theme.taglist_large_corner   = 6
theme.taglist_blink_interval = 0.5
-- }}}

-- {{{ Theming the menu
theme.menu_submenu_icon = themes_dir .. "/menu/submenu.png"
theme.menu_edit_icon = themes_dir .. "/menu/edit.svg"
theme.menu_refresh_icon = themes_dir .. "/menu/refresh.svg"
theme.menu_height = 24
theme.menu_width  = 200
-- }}}

-- {{{ Theming the widget
theme.top_panel_height = 18
theme.bottom_panel_height = 28
theme.widget_mem = themes_dir .. "/widget/mem.png"
theme.widget_cpu = themes_dir .. "/widget/cpu.png"
theme.widget_temp = themes_dir .. "/widget/temp.png"
theme.widget_hdd = themes_dir .. "/widget/hdd.png"
theme.widget_battery_no = themes_dir .. "/widget/battery_no.png"
theme.widget_battery_empty = themes_dir .. "/widget/battery_empty.png"
theme.widget_battery_low = themes_dir .. "/widget/battery_low.png"
theme.widget_battery_normal = themes_dir .. "/widget/battery_normal.png"
theme.widget_net = themes_dir .. "/widget/net.png"
theme.widget_clock = themes_dir .. "/widget/clock.png"
theme.widget_music_off = themes_dir .. "/widget/music_off.png"
theme.widget_music_on = themes_dir .. "/widget/music_on.png"
theme.widget_vol = themes_dir .. "/widget/vol.png"
theme.widget_vol_low = themes_dir .. "/widget/vol_low.png"
theme.widget_vol_no = themes_dir .. "/widget/vol_no.png"
theme.widget_vol_mute = themes_dir .. "/widget/vol_mute.png"
-- }}}

-- {{{ Theming taskbar
theme.tasklist_disable_icon = false
theme.tasklist_floating = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical = ""
theme.tasklist_margin_top = theme.taglist_margin_top
-- }}}

-- {{{ Theming layout
theme.layout_centerworkd = themes_dir .. "/layouts/centerworkd.png"
theme.layout_floating = themes_dir .. "/layouts/floating.png"
theme.layout_magnifier = themes_dir .. "/layouts/magnifier.png"
theme.layout_tileleft = themes_dir .. "/layouts/tileleft.png"
theme.layout_tile = themes_dir .. "/layouts/tile.png"
-- }}}

-- {{{ Normal icon
theme.awesome_icon = themes_dir .. "/icons/awesome-icon.png"
theme.icon_theme = "Moka"
theme.tux = themes_dir .. "/icons/logo-arch.png"
-- }}}

return theme
