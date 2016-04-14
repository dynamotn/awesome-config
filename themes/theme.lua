-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
theme = {}
themes_dir = os.getenv("HOME") .. "/.config/awesome/themes"

theme.font            = "Terminess Powerline 9"
theme.font_background = "Terminess Powerline 13"

-- {{{ Color
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

-- Text color
theme.fg_confirm    = '#4caf50'
theme.fg_command    = '#2196f3'

-- Widget color
theme.bg_widget     = { '#ececec',
                        '#7d9f73',
                        '#124e8a',
                        '#03396c',
                        '#011f4b' }
theme.bg_panel      = '#313131'

theme.fg_mem        = '#696c69'
theme.fg_hour       = '#de5e1e'
theme.fg_date       = '#7788af'
-- }}}

-- Display the taglist squares
theme.taglist_squares_sel   = themes_dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = themes_dir .. "/taglist/squarew.png"

-- {{{ Theming the menu:
theme.menu_submenu_icon = themes_dir .. "/menu/submenu.png"
theme.menu_edit_icon = themes_dir .. "/menu/edit.svg"
theme.menu_refresh_icon = themes_dir .. "/menu/refresh.svg"
theme.menu_height = 24
theme.menu_width  = 200
-- }}}

-- {{{ Theming the widget
theme.top_panel_height = 18
theme.bottom_panel_height = 25
theme.widget_mem = themes_dir .. "/widget/mem.png"
theme.widget_clock = themes_dir .. "/widget/clock.png"
-- }}}

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
theme.layout_fairv = themes_dir .. "/layouts/fairv.png"
theme.layout_floating  = themes_dir .. "/layouts/floating.png"
theme.layout_magnifier = themes_dir .. "/layouts/magnifier.png"
theme.layout_tileleft   = themes_dir .. "/layouts/tileleft.png"
theme.layout_tile = themes_dir .. "/layouts/tile.png"

-- {{{ Normal icon
theme.awesome_icon = themes_dir .. "/icons/awesome-icon.png"
theme.icon_theme = "Moka"
theme.tux = themes_dir .. "/icons/logo-arch.png"
-- }}}

return theme
