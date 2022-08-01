-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Custom library
local misc = require('dynamo.misc')

-- { Miscellaneous function
local function toggle_show_client(c)
  if c == client.focus then
    c.minimized = true
  else
    c:emit_signal('request::activate', 'tasklist', { raise = true })
  end
end
-- }

-- { List mouse bindings
-- Global buttons
local list_global_buttons = {
  ['workspace'] = {
    {
      {},
      1,
      function(t)
        t:view_only()
      end,
    },
    {
      { modkey },
      1,
      function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end,
    },
    { {}, 3, awful.tag.viewtoggle },
    {
      { modkey },
      3,
      function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end,
    },
    {
      {},
      4,
      function(t)
        awful.tag.viewnext(t.screen)
      end,
    },
    {
      {},
      5,
      function(t)
        awful.tag.viewprev(t.screen)
      end,
    },
  },
  ['taskbar'] = {
    { {}, 1, toggle_show_client },
    {
      {},
      3,
      function()
        awful.menu.client_list({ theme = { width = 250 } })
      end,
    },
    {
      {},
      4,
      function()
        awful.client.focus.byidx(1)
      end,
    },
    {
      {},
      5,
      function()
        awful.client.focus.byidx(-1)
      end,
    },
  },
  ['window'] = {
    {
      {},
      1,
      function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
      end,
    },
    {
      { modkey },
      1,
      function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.move(c)
      end,
    },
    {
      { modkey },
      3,
      function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.resize(c)
      end,
    },
  },
  ['layout'] = {
    {
      {},
      1,
      function()
        awful.layout.inc(1)
      end,
    },
    {
      {},
      3,
      function()
        awful.layout.inc(-1)
      end,
    },
    {
      {},
      4,
      function()
        awful.layout.inc(1)
      end,
    },
    {
      {},
      5,
      function()
        awful.layout.inc(-1)
      end,
    },
  },
  ['desktop'] = {
    {
      {},
      3,
      function()
        main_menu:toggle()
      end,
    },
    { {}, 4, awful.tag.viewnext },
    { {}, 5, awful.tag.viewprev },
  },
}

-- Widget button
local list_widget_buttons = {
  ['music'] = {
    {
      {},
      1,
      function()
        misc.run_at_workspace(music_cmd, music_workspace)
      end,
    },
  },
}
-- }

-- { Global buttons
global_buttons = {}
for group, list_group_buttons in pairs(list_global_buttons) do
  global_buttons[group] = {}
  for _, group_buttons in ipairs(list_group_buttons) do
    table.merge(global_buttons[group], awful.button(group_buttons[1], group_buttons[2], group_buttons[3]))
  end
end
-- }

-- { Widget button
widget_buttons = {}
for group, list_group_buttons in pairs(list_widget_buttons) do
  widget_buttons[group] = {}
  for _, group_buttons in ipairs(list_group_buttons) do
    table.merge(widget_buttons[group], awful.button(group_buttons[1], group_buttons[2], group_buttons[3]))
  end
end
-- }
