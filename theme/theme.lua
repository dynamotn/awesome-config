local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local util = require('awful.util')
local local_theme_path = util.getdir('config') .. '/theme/'

local theme = {}

-- { Font
theme.font = 'Iosevka Dynamo 11'
theme.tasklist_font = 'Iosevka Dynamo 11'
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

-- Common powerline section
theme.powerline_bgs = {
  '#01579b' .. theme.alpha_color_suffix,
  '#0277bd' .. theme.alpha_color_suffix,
  '#0288d1' .. theme.alpha_color_suffix,
  '#039be5' .. theme.alpha_color_suffix,
  '#03a9f4' .. theme.alpha_color_suffix,
  '#29b6f6' .. theme.alpha_color_suffix,
  '#4fc3f7' .. theme.alpha_color_suffix,
  '#81d4fa' .. theme.alpha_color_suffix,
}
theme.powerline_fgs = {
  '#263238',
  '#37474f',
  '#455a64',
  '#546e7a',
  '#607d8b',
  '#78909c',
  '#90a4ae',
  '#b0bec5',
}
theme.powerline_symbol = 'arrow'
theme.powerline_style = 'solid'

-- Background
theme.bg_normal = '#263238' .. theme.alpha_color_suffix
theme.bg_focus = '#37474f' .. theme.alpha_color_suffix
theme.bg_urgent = '#00c853' .. theme.alpha_color_suffix
theme.bg_systray = '#313131' .. theme.alpha_color_suffix

-- Foreground
theme.fg_normal = '#fafafa'
theme.fg_focus = '#eeeeee'
theme.fg_urgent = theme.powerline_fgs[8]

-- Border
theme.border_normal = theme.bg_focus
theme.border_focus = theme.powerline_bgs[2]

-- Workspace panel
theme.taglist_bg_empty = theme.bg_focus
theme.taglist_bg_focus = theme.powerline_fgs[6]
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_empty = theme.bg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_occupied = theme.fg_focus
theme.taglist_fg_urgent = theme.fg_urgent

-- Window panel
theme.tasklist_fg_normal = theme.powerline_fgs[8]
theme.tasklist_fg_minimize = '#777e76'
theme.tasklist_fg_focus = '#212121'
theme.tasklist_fg_urgent = '#f0f0f0'

-- Prompt panel
theme.prompt_bg_normal = '#f0f0f0' .. theme.alpha_color_suffix
if linux_distribution == 'archlinux' then
  theme.prompt_fg_normal = '#2196f3'
elseif linux_distribution == 'gentoo' then
  theme.prompt_fg_normal = '#846bcc'
elseif linux_distribution == 'ubuntu' then
  theme.prompt_fg_normal = '#fd6835'
else
  theme.prompt_fg_normal = '#feb50f'
end
theme.prompt_bg_cursor = theme.prompt_fg_normal
theme.prompt_fg_confirm = theme.prompt_fg_normal

-- Menu
theme.menu_bg_normal = theme.prompt_fg_normal
theme.menu_bg_focus = theme.prompt_bg_normal
theme.menu_fg_normal = theme.prompt_bg_normal
theme.menu_fg_focus = theme.prompt_fg_normal

-- Layout panel
theme.layout_bg_normal = theme.bg_systray

-- Vicious panel
theme.clock_fg_date = '#fafafa'
theme.clock_fg_hour = '#4a148c'
theme.network_fg_down = '#ffd600'
theme.network_fg_up = '#64dd17'
theme.cpu_fg = theme.powerline_fgs[8]
theme.music_fg_title = theme.powerline_fgs[8]

-- Titlebar
theme.titlebar_fg_close = '#ee4266'
theme.titlebar_fg_minimize = '#ffb400'
theme.titlebar_fg_maximize = '#4cbb17'
theme.titlebar_fg_floating = theme.powerline_bgs[2]
theme.titlebar_fg_ontop = theme.powerline_bgs[2]
theme.titlebar_fg_sticky = theme.powerline_bgs[2]

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

return theme
