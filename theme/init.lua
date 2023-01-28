local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local util = require('awful.util')
local local_theme_path = util.getdir('config') .. '/theme/'

local theme = {}

-- { Font
theme.font = 'Iosevka Dynamo 11'
theme.lockscreen_time_font = 'Iosevka Dynamo Bold 52'
theme.lockscreen_date_font = 'Iosevka Dynamo Italic 18'
theme.lockscreen_username_font = 'Pacifico 18'
theme.lockscreen_password_font = 'Symbol Nerd Fonts 12'
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font
theme.titlebar_font = theme.font
-- }

-- { Size
-- Border
theme.useless_gap = dpi(5)
theme.border_width = 0
theme.border_radius = dpi(10)

-- Menu
theme.menu_height = dpi(24)
theme.menu_width = dpi(160)

-- Panel
theme.top_panel_height = dpi(24)
theme.bottom_panel_height = dpi(36)

-- Workspace
theme.taglist_margin_left = dpi(4)
theme.taglist_margin_top = dpi(10)
theme.taglist_small_corner = dpi(4)
theme.taglist_large_corner = dpi(8)
theme.taglist_blink_interval = 0.5

-- Taskbar
theme.tasklist_margin_top = theme.taglist_margin_top

-- Titlebar
theme.titlebar_height = dpi(28)
-- }

-- { Color
theme.alpha_color_suffix = 'aa'
theme.base_colors = {
  '#b7bdf8',
  '#8aadf4',
  '#7dc4e4',
  '#91d7e3',
  '#8bd5ca',
  '#a6da95',
  '#eed49f',
  '#f5a97f',
  '#ee99a0',
  '#ed8796',
  '#c6a0f6',
  '#f5bde6',
  '#f0c6c6',
  '#f4dbd6',
}
theme.bonus_colors = {
  crust = '#181926',
  mantle = '#1e2030',
  base = '#24273a',
  surface0 = '#363a4f',
  surface1 = '#494d64',
  surface2 = '#5b6078',
  overlay0 = '#6e738d',
  overlay1 = '#8087a2',
  overlay2 = '#939ab7',
  subtext0 = '#a5adcb',
  subtext1 = '#b8c0e0',
  text = '#cad3f5',
}

-- Common powerline section
theme.powerline_bgs = {}
for _, color in ipairs(theme.base_colors) do
  table.insert(theme.powerline_bgs, color .. theme.alpha_color_suffix)
end

theme.powerline_symbol = 'arrow'
theme.powerline_style = 'solid'

-- Background
theme.bg_normal = theme.bonus_colors['base'] .. theme.alpha_color_suffix
theme.bg_focus = theme.bonus_colors['surface2'] .. theme.alpha_color_suffix
theme.bg_urgent = theme.base_colors[6] .. theme.alpha_color_suffix
theme.bg_systray = theme.bonus_colors['crust'] .. theme.alpha_color_suffix

-- Foreground
theme.fg_normal = theme.bonus_colors['text']
theme.fg_focus = theme.bonus_colors['mantle']
theme.fg_urgent = theme.bonus_colors['base']
theme.fg_warning = theme.base_colors[10]

-- Border
theme.border_normal = theme.bg_focus

-- Workspace panel
theme.taglist_bg_empty = theme.bonus_colors['crust']
theme.taglist_bg_focus = theme.bonus_colors['subtext1']
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_empty = theme.bonus_colors['surface0']
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_occupied = theme.bonus_colors['text']
theme.taglist_fg_urgent = theme.fg_urgent

-- Window panel
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_fg_minimize = theme.bonus_colors['subtext0']
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.bonus_colors['subtext1']

-- Prompt panel
if linux_distribution == 'archlinux' then
  theme.prompt_bg_normal = theme.base_colors[4] .. theme.alpha_color_suffix
elseif linux_distribution == 'gentoo' then
  theme.prompt_bg_normal = theme.base_colors[11] .. theme.alpha_color_suffix
elseif linux_distribution == 'ubuntu' then
  theme.prompt_bg_normal = theme.base_colors[8] .. theme.alpha_color_suffix
else
  theme.prompt_bg_normal = theme.base_colors[7] .. theme.alpha_color_suffix
end
theme.prompt_fg_normal = theme.fg_normal
theme.prompt_fg_confirm = theme.prompt_fg_normal

-- Menu
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.prompt_bg_normal
theme.menu_fg_normal = theme.prompt_bg_normal
theme.menu_fg_focus = theme.prompt_fg_normal

-- Layout panel
theme.layout_bg_normal = theme.bg_normal

-- Vicious panel
theme.clock_fg_date = theme.bonus_colors['mantle']
theme.clock_fg_hour = theme.fg_normal
theme.network_fg_down = theme.base_colors[7]
theme.network_fg_up = theme.base_colors[6]
theme.cpu_fg = theme.bonus_colors['text']
theme.music_fg_title = theme.bonus_colors['text']

-- Titlebar
theme.titlebar_fg_close = theme.base_colors[10]
theme.titlebar_fg_minimize = theme.base_colors[7]
theme.titlebar_fg_maximize = theme.base_colors[6]
theme.titlebar_fg_floating = theme.powerline_bgs[1]
theme.titlebar_fg_ontop = theme.powerline_bgs[2]
theme.titlebar_fg_sticky = theme.powerline_bgs[3]

-- Popup
theme.popup_fg_htop_title = theme.bg_urgent
-- }

-- { Image
-- Menu
theme.menu_submenu_icon = local_theme_path .. 'menu/submenu.png'
theme.menu_edit_icon = local_theme_path .. 'menu/edit.svg'
theme.menu_restart_icon = local_theme_path .. 'menu/restart.svg'

-- { Widget
-- Clock
theme.clock_icon = local_theme_path .. 'widget/clock.png'

-- Network
theme.network_icon = local_theme_path .. 'widget/network.png'

-- Power
theme.power_icon_ac = local_theme_path .. 'widget/power_ac.png'
theme.power_icon_very_low = local_theme_path .. 'widget/power_very_low.png'
theme.power_icon_low = local_theme_path .. 'widget/power_low.png'
theme.power_icon_normal = local_theme_path .. 'widget/power_normal.png'

-- Memory
theme.memory_icon = local_theme_path .. 'widget/mem.png'

-- CPU
theme.cpu_icon = local_theme_path .. 'widget/cpu.png'

-- Volume
theme.volume_icon_mute = local_theme_path .. 'widget/volume_mute.png'
theme.volume_icon_no = local_theme_path .. 'widget/volume_no.png'
theme.volume_icon_low = local_theme_path .. 'widget/volume_low.png'
theme.volume_icon_normal = local_theme_path .. 'widget/volume_normal.png'

-- Music
theme.music_icon_on = local_theme_path .. 'widget/music_on.png'
theme.music_icon_off = local_theme_path .. 'widget/music_off.png'
-- }

-- Layout
theme.layout_fairh = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating = local_theme_path .. 'layouts/floating.png'
theme.layout_magnifier = local_theme_path .. 'layouts/magnifier.png'
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_tile = local_theme_path .. 'layouts/tile.png'
theme.layout_cornernw = themes_path .. 'default/layouts/cornernww.png'

-- Taskbar
theme.tasklist_bg_image_normal = local_theme_path .. 'background/gray.png'
theme.tasklist_bg_image_minimize = local_theme_path .. 'background/black.png'
theme.tasklist_bg_image_focus = local_theme_path .. 'background/white.png'
theme.tasklist_bg_image_urgent = local_theme_path .. 'background/blue.png'

-- Generate Awesome icon:
theme.launcher_icon = local_theme_path .. 'icons/' .. linux_distribution .. '.png'
theme.awesome_icon = local_theme_path .. 'icons/awesome.png'

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Moka'
-- }

-- { Notification
theme.notification_position = 'top_right'
theme.notification_bg = theme.bonus_colors['crust']
theme.notification_margin = dpi(16)
theme.notification_border_width = 0
theme.notification_spacing = dpi(8)
theme.notification_icon_size = dpi(32)
-- }

return theme
