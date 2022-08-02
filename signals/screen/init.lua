-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
-- Widget and layout library
local wibox = require('wibox')
-- Custom library
local misc = require('dynamo.misc')
local separator = require('dynamo.widget').separator
local bar = require('dynamo.bar')
local init_popup = require('dynamo.notify').init_popup
local get_processes_info = require('dynamo.misc').get_processes_info
-- Bindings
local bindings = require('bindings')

-- Restart awesome when screens are removed or added
screen.connect_signal('added', awesome.restart)
screen.connect_signal('removed', awesome.restart)

-- Setup wallpaper
screen.connect_signal('request::wallpaper', function(s)
  misc.auto_change_wallpaper(s)
end)

-- Setup screen
screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag(workspaces, s, layouts[3])

  -- Create a promptbox for each screen
  s.prompt_box = awful.widget.prompt({ prompt = '' })
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.layout_box = dynamo_layout(s)
  -- Create a workspace widget
  s.workspace_list = bar.workspace_list({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = bindings.config.mouse.global.workspace,
  })

  -- Create a window list widget
  s.window_list = bar.window_list({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = bindings.config.mouse.global.taskbar,
  })

  -- Create the wibox
  s.top_wibox = awful.wibar({ position = 'top', screen = s, height = beautiful.top_panel_height })
  s.bottom_wibox = awful.wibar({ position = 'bottom', screen = s, height = beautiful.bottom_panel_height })

  -- Add widgets to the wibox
  s.top_wibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      dynamo_prompt,
      dynamo_space,
      s.prompt_box,
    },
    nil, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        layout = awful.widget.only_on_screen,
        screen = awful.screen.focused(),
        {
          layout = wibox.layout.fixed.horizontal,
          separator(beautiful.powerline_symbol, 'left', 'chevron', beautiful.bg_focus, beautiful.bg_normal),
          dynamo_keyboard,
          wibox.widget.systray(),
          wibox.container.background(wibox.widget.textbox(' '), beautiful.bg_systray),
          separator(beautiful.powerline_symbol, 'left', 'solid', beautiful.bg_normal, beautiful.bg_focus),
        },
      },
      dynamo_music,
      dynamo_volume,
      dynamo_cpu,
      dynamo_memory,
      dynamo_power,
      dynamo_network,
      dynamo_clock,
      s.layout_box,
    },
  })
  init_popup(s.top_wibox:get_children_by_id(dynamo_memory.id)[1], get_processes_info)
  s.top_wibox:get_children_by_id(s.layout_box.id)[1]:buttons(bindings.config.mouse.global.layout)
  s.top_wibox:get_children_by_id(dynamo_music.id)[1]:buttons(bindings.config.mouse.widgets.music)

  s.bottom_wibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.workspace_list,
    },
    s.window_list, -- Middle widget
  })
end)
