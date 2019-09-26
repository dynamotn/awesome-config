local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local util = require("awful.util")
local local_theme_path = util.getdir("config") .. "/theme/"

local theme = {}

-- { Font
theme.font                     = "xos4 Terminus 9"
theme.tasklist_font            = "Monofur Nerd Font 11"
theme.hotkeys_font             = theme.font
theme.hotkeys_description_font = theme.font
-- }

-- { Size
-- Border
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Menu
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)

-- Panel
theme.top_panel_height = dpi(18)
theme.bottom_panel_height = dpi(28)
-- }

-- { Color
-- Background
theme.bg_normal   = "#1a1a1a"
theme.bg_focus    = "#313131"
theme.bg_urgent   = "#212121"
theme.bg_minimize = "#414141"
theme.bg_systray  = theme.bg_normal

-- Foreground
theme.fg_normal   = "#ddddff"
theme.fg_focus    = "#f0dfaf"
theme.fg_urgent   = "#33b5e5"
theme.fg_minimize = "#ffffff"

-- Border
theme.border_normal = "#3f3f3f"
theme.border_focus  = "#7f7f7f"
theme.border_marked = "#cc9393"

-- Workspace panel
theme.taglist_bg_empty    = "#313131"
theme.taglist_bg_focus    = "#45aacc"
theme.taglist_bg_urgent   = "#45bf55"
theme.taglist_fg_focus    = "#fff3f3"
theme.taglist_fg_occupied = "#acacac"
theme.taglist_fg_empty    = "#1a1a1a"
theme.taglist_fg_urgent   = "#fff3f3"

-- Window panel
theme.tasklist_fg_normal   = "#fff3f3"
theme.tasklist_fg_minimize = "#777e76"
theme.tasklist_fg_focus    = "#212121"
theme.tasklist_fg_urgent   = "#f0f0f0"

-- Prompt panel
theme.prompt_bg_normal = "#f0f0f0"
if linux_distribution == "archlinux" then
  theme.prompt_fg_normal = "#2196f3"
elseif linux_distribution == "gentoo" then
  theme.prompt_fg_normal = "#846bcc"
elseif linux_distribution == "ubuntu" then
  theme.prompt_fg_normal = "#fd6835"
else
  theme.prompt_fg_normal = "#feb50f"
end
-- }

-- { Image
-- Menu
theme.menu_submenu_icon = local_theme_path.."menu/submenu.png"
theme.menu_edit_icon = local_theme_path.."menu/edit.svg"
theme.menu_restart_icon = local_theme_path.."menu/restart.svg"

theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.launcher_icon = local_theme_path .. "icons/" .. linux_distribution .. ".png"
theme.awesome_icon  = local_theme_path .. "icons/awesome.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Moka"
-- }

return theme
