---------------------------
-- Default awesome theme --
---------------------------

theme = {}
themes_dir = os.getenv("HOME") .. "/.config/awesome/themes"

theme.font          = "Terminess Powerline 9"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- Display the taglist squares
theme.taglist_squares_sel   = themes_dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = themes_dir .. "/taglist/squarew.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon = themes_dir .. "/submenu.png"
theme.menu_height = 24
theme.menu_width  = 200

-- Define the image to load
theme.titlebar_close_button_normal = themes_dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_dir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_dir .. "/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_dir .. "/layouts/fairhw.png"
theme.layout_fairv = themes_dir .. "/layouts/fairvw.png"
theme.layout_floating  = themes_dir .. "/layouts/floatingw.png"
theme.layout_magnifier = themes_dir .. "/layouts/magnifierw.png"
theme.layout_max = themes_dir .. "/layouts/maxw.png"
theme.layout_fullscreen = themes_dir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_dir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_dir .. "/layouts/tileleftw.png"
theme.layout_tile = themes_dir .. "/layouts/tilew.png"
theme.layout_tiletop = themes_dir .. "/layouts/tiletopw.png"
theme.layout_spiral  = themes_dir .. "/layouts/spiralw.png"
theme.layout_dwindle = themes_dir .. "/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Moka"
theme.tux = themes_dir .. "/icons/logo-arch.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
