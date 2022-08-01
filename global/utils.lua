-- { Localization
os.setlocale(os.getenv('LANG'))
-- }

-- { Vendor modules
local awful = require('awful')
local local_rc_path = awful.util.get_configuration_dir()
package.path = package.path .. ';' .. local_rc_path .. 'vendor/?.lua;' .. local_rc_path .. 'vendor/?/init.lua;'
-- }

-- { Reconfigure notification
local naughty = require('naughty')
naughty.config.defaults.timeout = 10
-- }

-- { Initial theme
local beautiful = require('beautiful')
beautiful.init(theme_location)
-- }

-- { Window decorations
local nice = require('nice')
nice({
  titlebar_font = beautiful.titlebar_font,
  titlebar_height = beautiful.titlebar_height,
  context_menu_theme = {
    font = beautiful.titlebar_font,
  },
  close_color = beautiful.titlebar_fg_close,
  minimize_color = beautiful.titlebar_fg_minimize,
  maximize_color = beautiful.titlebar_fg_maximize,
  floating_color = beautiful.titlebar_fg_floating,
  ontop_color = beautiful.titlebar_fg_ontop,
  sticky_color = beautiful.titlebar_fg_sticky,
  -- Swap the designated buttons for resizing, and opening the context menu
  mb_resize = nice.MB_MIDDLE,
  mb_contextmenu = nice.MB_RIGHT,
  -- Change default position of buttons on titlebar
  titlebar_items = {
    left = { 'sticky', 'ontop', 'floating' },
    right = { 'minimize', 'maximize', 'close' },
    middle = 'title',
  },
})
-- }

-- { Setup layouts
local awful = require('awful')
awful.layout.layouts = layouts
-- }

-- { Reconfigure menubar
local menubar = require('menubar')
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }
