-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
-- Widget and layout library
local wibox = require('wibox')
-- Custom library
local init_popup = require('lib.notify').init_popup
local get_processes_info = require('lib.os').get_processes_info
-- Bindings
local bindings = require('bindings')
-- Configuration
local layouts = require('config.layouts')
local workspaces = require('config.workspaces')
-- Widgets
local widgets = require('widgets')

screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag(workspaces.list[s.index], s, layouts[s.index == 1 and 3 or 4])

  -- Create all widgets on wibox
  s.panel = require('signals.screen.panel')

  -- Create a promptbox for each screen
  s.prompt_box = awful.widget.prompt({ prompt = '' })
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.layout_box = s.panel.layout(s)
  -- Create a workspace widget
  s.workspace_list = widgets.workspace_list({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = bindings.config.mouse.global.workspace,
  })

  -- Create a window list widget
  s.window_list = widgets.window_list({
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
      s.panel.prompt,
      s.panel.space,
      s.prompt_box,
    },
    nil, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        layout = awful.widget.only_on_screen,
        screen = 'primary',
        {
          layout = wibox.layout.fixed.horizontal,
          widgets.components.separator(
            beautiful.powerline_symbol,
            'left',
            'chevron',
            beautiful.bg_focus,
            beautiful.bg_normal
          ),
          s.panel.keyboard,
          wibox.widget.systray(),
          wibox.container.background(wibox.widget.textbox(' '), beautiful.bg_systray),
          widgets.components.separator(
            beautiful.powerline_symbol,
            'left',
            'solid',
            beautiful.bg_normal,
            beautiful.bg_focus
          ),
        },
      },
      s.panel.music,
      s.panel.volume,
      s.panel.cpu,
      s.panel.memory,
      s.panel.power,
      s.panel.network,
      s.panel.clock,
      s.layout_box,
    },
  })
  init_popup(s.top_wibox:get_children_by_id(s.panel.memory.id)[1], get_processes_info)
  s.top_wibox:get_children_by_id(s.layout_box.id)[1]:buttons(bindings.config.mouse.global.layout)
  s.top_wibox:get_children_by_id(s.panel.music.id)[1]:buttons(bindings.config.mouse.widgets.music)
  s.top_wibox:get_children_by_id(s.panel.cpu.id)[1]:buttons(bindings.config.mouse.widgets.monitor)
  s.top_wibox:get_children_by_id(s.panel.memory.id)[1]:buttons(bindings.config.mouse.widgets.monitor)
  s.top_wibox:get_children_by_id(s.panel.network.id)[1]:buttons(bindings.config.mouse.widgets.monitor)

  s.bottom_wibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.workspace_list,
    },
    s.window_list, -- Middle widget
  })
end)
