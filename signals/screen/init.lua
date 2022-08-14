require('signals.screen.wallpaper')
require('signals.screen.lockscreen')
require('signals.screen.workscreen')

-- Restart awesome when screens are removed or added
screen.connect_signal('added', awesome.restart)
screen.connect_signal('removed', awesome.restart)

-- Setup wallpaper
screen.connect_signal('request::wallpaper', function(s)
  local all_wallpapers = filesystem.scan_dir_by_mime(filesystem.xdg_user_dirs('PICTURES') .. '/Wallpaper', 'image')
  local current_wallpaper

  local timer = gears.timer.start_new(5, function()
    if next(all_wallpapers) ~= nil then
      if current_wallpaper == nil then
        current_wallpaper = all_wallpapers[math.random(1, #all_wallpapers)]
      end
      gears.wallpaper.maximized(current_wallpaper, s, false)
    end
    collectgarbage('collect')
  end)

  timer:connect_signal('timeout', function()
    timer:start()
  end)
end)

-- Setup screen
screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag(workspaces.list[s.index], s, layouts[s.index == 1 and 3 or 4])

  -- Create a promptbox for each screen
  s.prompt_box = awful.widget.prompt({ prompt = '' })
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.layout_box = panel.layout(s)
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

  -- Create lockscreen
  s.lockscreen = awful.wibar({
    screen = s,
    visible = false,
    ontop = true,
    type = 'splash',
    width = s.geometry.width,
    height = s.geometry.height,
  })

  s.lockscreen:setup({
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
      layout = wibox.layout.align.horizontal,
      expand = 'none',
    },
  })

  -- Create the wibox
  s.top_wibox = awful.wibar({ position = 'top', screen = s, height = beautiful.top_panel_height })
  s.bottom_wibox = awful.wibar({ position = 'bottom', screen = s, height = beautiful.bottom_panel_height })

  -- Add widgets to the wibox
  s.top_wibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      panel.prompt,
      panel.space,
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
          panel.keyboard,
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
      panel.music,
      panel.volume,
      panel.cpu,
      panel.memory,
      panel.power,
      panel.network,
      panel.clock,
      s.layout_box,
    },
  })
  init_popup(s.top_wibox:get_children_by_id(panel.memory.id)[1], get_processes_info)
  s.top_wibox:get_children_by_id(s.layout_box.id)[1]:buttons(bindings.config.mouse.global.layout)
  s.top_wibox:get_children_by_id(panel.music.id)[1]:buttons(bindings.config.mouse.widgets.music)

  s.bottom_wibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.workspace_list,
    },
    s.window_list, -- Middle widget
  })
end)
