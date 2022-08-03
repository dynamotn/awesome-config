local beautiful = require('beautiful')

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

-- { Reconfigure menubar
local menubar = require('menubar')
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }
