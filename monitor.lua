-- AwesomeWM standard library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
-- Widget and layout library
local wibox = require("wibox")
-- Custom library
local misc = require("dynamo.misc")

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  misc.auto_change_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(workspaces, s, layouts[1])

  -- Create a promptbox for each screen
  s.dynamo_promptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.dynamo_layoutbox = awful.widget.layoutbox(s)
  s.dynamo_layoutbox:buttons(layoutbuttons)
  -- Create a taglist widget
  s.dynamo_taglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.dynamo_tasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.dynamo_top_wibox = awful.wibar({ position = "top", screen = s, height = beautiful.top_panel_height })
  s.dynamo_bottom_wibox = awful.wibar({ position = "bottom", screen = s, height = beautiful.bottom_panel_height })

  -- Add widgets to the wibox
  s.dynamo_top_wibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      dynamo_launcher,
      s.dynamo_promptbox,
    },
    nil, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      dynamo_powerline_prompt_box,
      dynamo_keyboard_layout,
      wibox.widget.systray(),
      dynamo_text_clock,
      s.dynamo_layoutbox,
    },
  }
  s.dynamo_bottom_wibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.dynamo_taglist,
    },
    s.dynamo_tasklist, -- Middle widget
  }
end)
