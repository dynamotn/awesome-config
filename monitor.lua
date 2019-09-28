-- AwesomeWM standard library
local awful = require("awful")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")
-- Widget and layout library
local wibox = require("wibox")
-- Custom library
local misc = require("dynamo.misc")
local separator = require("dynamo.widget").separator

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  misc.auto_change_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(workspaces, s, layouts[3])

  -- Create a promptbox for each screen
  s.promptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.layoutbox = dynamo_layout(s)
  s.layoutbox:set_buttons(layoutbuttons)
  -- Create a taglist widget
  s.taglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.tasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.top_wibox = awful.wibar({ position = "top", screen = s, height = beautiful.top_panel_height })
  s.bottom_wibox = awful.wibar({ position = "bottom", screen = s, height = beautiful.bottom_panel_height })

  -- Add widgets to the wibox
  s.top_wibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      dynamo_prompt,
      s.promptbox,
    },
    nil, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        layout = awful.widget.only_on_screen,
        screen = awful.screen.focused(),
        {
          layout = wibox.layout.fixed.horizontal,
          separator(beautiful.powerline_symbol, "left", "chevron", beautiful.bg_focus, beautiful.bg_normal),
          dynamo_keyboard,
          wibox.widget.systray(),
          wibox.container.background(wibox.widget.textbox(' '), beautiful.bg_systray),
          separator(beautiful.powerline_symbol, "left", "solid", beautiful.bg_normal, beautiful.bg_focus),
        }
      },
      dynamo_volume,
      dynamo_cpu,
      dynamo_memory,
      dynamo_power,
      dynamo_network,
      dynamo_clock,
      s.layoutbox,
    },
  }
  s.bottom_wibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.taglist,
    },
    s.tasklist, -- Middle widget
  }
end)
