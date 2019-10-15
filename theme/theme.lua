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
theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_radius = dpi(10)

-- Menu
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)

-- Panel
theme.top_panel_height = dpi(18)
theme.bottom_panel_height = dpi(28)

-- Workspace
theme.taglist_margin_left    = 3
theme.taglist_margin_top     = 8
theme.taglist_small_corner   = 2
theme.taglist_large_corner   = 6
theme.taglist_blink_interval = 0.5

-- Taskbar
theme.tasklist_margin_top = theme.taglist_margin_top
-- }

-- { Color
-- Common powerline section
theme.powerline_bgs = {
  "#f0f0f0",
  "#44c0dd",
  "#0c273d",
  "#2c5e2e",
  "#70b85d",
}
theme.powerline_symbol = "arrow"

-- Background
theme.bg_normal   = "#1a1a1a"
theme.bg_focus    = "#313131"
theme.bg_urgent   = "#4caf50"
theme.bg_systray  = theme.bg_focus

-- Foreground
theme.fg_normal   = theme.powerline_bgs[1]
theme.fg_focus    = "#d5d5d5"
theme.fg_urgent   = "#d0f0f1"

-- Border
theme.border_normal = theme.bg_focus
theme.border_focus  = theme.powerline_bgs[2]

-- Workspace panel
theme.taglist_bg_empty    = theme.bg_focus
theme.taglist_bg_focus    = theme.powerline_bgs[2]
theme.taglist_bg_urgent   = theme.bg_urgent
theme.taglist_fg_empty    = theme.bg_normal
theme.taglist_fg_focus    = theme.fg_focus
theme.taglist_fg_occupied = theme.fg_focus
theme.taglist_fg_urgent   = theme.fg_urgent

-- Window panel
theme.tasklist_fg_normal   = "#fff3f3"
theme.tasklist_fg_minimize = "#777e76"
theme.tasklist_fg_focus    = "#212121"
theme.tasklist_fg_urgent   = "#f0f0f0"

-- Prompt panel
theme.prompt_bg_normal = theme.fg_normal
if linux_distribution == "archlinux" then
  theme.prompt_fg_normal = "#2196f3"
elseif linux_distribution == "gentoo" then
  theme.prompt_fg_normal = "#846bcc"
elseif linux_distribution == "ubuntu" then
  theme.prompt_fg_normal = "#fd6835"
else
  theme.prompt_fg_normal = "#feb50f"
end
theme.prompt_bg_cursor = theme.prompt_fg_normal
theme.prompt_fg_confirm = theme.prompt_fg_normal

-- Menu
theme.menu_bg_normal = theme.prompt_fg_normal
theme.menu_bg_focus  = theme.prompt_bg_normal
theme.menu_fg_normal = theme.prompt_bg_normal
theme.menu_fg_focus  = theme.prompt_fg_normal

-- Layout panel
theme.layout_bg_normal = theme.bg_systray

-- Vicious panel
theme.clock_fg_date   = theme.bg_normal
theme.clock_fg_hour   = theme.fg_normal
theme.network_fg_down = theme.powerline_bgs[2]
theme.network_fg_up   = theme.powerline_bgs[5]
theme.cpu_fg          = theme.powerline_bgs[2]
theme.music_fg_title  = theme.powerline_bgs[2]
-- }

-- { Image
-- Menu
theme.menu_submenu_icon = local_theme_path .. "menu/submenu.png"
theme.menu_edit_icon    = local_theme_path .. "menu/edit.svg"
theme.menu_restart_icon = local_theme_path .. "menu/restart.svg"

-- { Title bar
-- Close
theme.titlebar_close_button_normal = local_theme_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = local_theme_path .. "titlebar/close_focus.png"

-- Minimize
theme.titlebar_minimize_button_normal = local_theme_path .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = local_theme_path .. "titlebar/minimize_focus.png"

-- On top
theme.titlebar_ontop_button_normal_inactive = local_theme_path .. "titlebar/ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = local_theme_path .. "titlebar/ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active   = local_theme_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active    = local_theme_path .. "titlebar/ontop_focus_active.png"
-- Sticky
theme.titlebar_sticky_button_normal_inactive = local_theme_path .. "titlebar/sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = local_theme_path .. "titlebar/sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active   = local_theme_path .. "titlebar/sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active    = local_theme_path .. "titlebar/sticky_focus_active.svg"

-- Floating
theme.titlebar_floating_button_normal_inactive = local_theme_path .. "titlebar/floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = local_theme_path .. "titlebar/floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active   = local_theme_path .. "titlebar/floating_normal_active.svg"
theme.titlebar_floating_button_focus_active    = local_theme_path .. "titlebar/floating_focus_active.svg"

-- Maximized
theme.titlebar_maximized_button_normal_inactive = local_theme_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = local_theme_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = local_theme_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = local_theme_path .. "titlebar/maximized_focus_active.png"
-- }

-- { Widget
-- Clock
theme.clock_icon = local_theme_path .. "widget/clock.png"

-- Network
theme.network_icon = local_theme_path .. "widget/network.png"

-- Power
theme.power_icon_ac       = local_theme_path .. "widget/power_ac.png"
theme.power_icon_very_low = local_theme_path .. "widget/power_very_low.png"
theme.power_icon_low      = local_theme_path .. "widget/power_low.png"
theme.power_icon_normal   = local_theme_path .. "widget/power_normal.png"

-- Memory
theme.memory_icon = local_theme_path .. "widget/mem.png"

-- CPU
theme.cpu_icon = local_theme_path .. "widget/cpu.png"

-- Volume
theme.volume_icon_mute   = local_theme_path .. "widget/volume_mute.png"
theme.volume_icon_no     = local_theme_path .. "widget/volume_no.png"
theme.volume_icon_low    = local_theme_path .. "widget/volume_low.png"
theme.volume_icon_normal = local_theme_path .. "widget/volume_normal.png"

-- Music
theme.music_icon_on  = local_theme_path .. "widget/music_on.png"
theme.music_icon_off = local_theme_path .. "widget/music_off.png"
-- }

-- Layout
theme.layout_fairh     = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv     = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating  = local_theme_path .. "layouts/floating.png"
theme.layout_magnifier = local_theme_path .. "layouts/magnifier.png"
theme.layout_max       = themes_path .. "default/layouts/maxw.png"
theme.layout_tile      = local_theme_path .. "layouts/tile.png"
theme.layout_cornernw  = themes_path .. "default/layouts/cornernww.png"

-- Taskbar
theme.tasklist_bg_image_normal   = local_theme_path .. 'background/gray.png'
theme.tasklist_bg_image_minimize = local_theme_path .. 'background/black.png'
theme.tasklist_bg_image_focus    = local_theme_path .. 'background/white.png'
theme.tasklist_bg_image_urgent   = local_theme_path .. 'background/blue.png'

-- Generate Awesome icon:
theme.launcher_icon = local_theme_path .. "icons/" .. linux_distribution .. ".png"
theme.awesome_icon  = local_theme_path .. "icons/awesome.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Moka"
-- }

return theme
