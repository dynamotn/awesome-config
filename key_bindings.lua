-- AwesomeWM standard library
local awful = require("awful")
-- Table utilities library
local table = require("gears.table")
-- Popup library
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")
-- Custom library
local dynamo = require("dynamo")

-- { Miscellaneous function
local function hide_panel()
  local screen = awful.screen.focused()
  screen.top_wibox.visible = not screen.top_wibox.visible
  screen.bottom_wibox.visible = not screen.bottom_wibox.visible
end

local function restore_minimized_window()
  local c = awful.client.restore()
  if c then
    c:emit_signal("request::activate", "key.unminimize", { raise = true })
  end
end

local function action_workspace(index, action)
  local screen = awful.screen.focused()
  local tag = screen.tags[index]
  if tag then
    if action then
      action(tag)
    else
      tag:view_only()
    end
  end
end
-- }

-- { List key bindings
-- Global
local list_global_keys = {
  ["awesome"] = {
    -- Common
    { { modkey            }, "s", "Show help", hotkeys_popup.show_help },
    { { modkey, "Control" }, "r", "Reload awesome", awesome.restart },
    { { modkey, "Shift"   }, "q", "Quit", awesome.quit },
    -- Prompt
    { { altkey            }, "F1", "Show properties of window", dynamo.notify.xprop },
    { { altkey            }, "F2", "Run command", function() if not dynamo_prompt.is_busy then awful.screen.focused().prompt_box:run() end end },
    { { altkey            }, "F3", "Calculation", dynamo.notify.calculation },
    -- Menu
    { { modkey            }, "F1", "Show main menu", function() main_menu:show() end },
    { { modkey            }, "F2", "Show menubar", menubar.show },
  },
  ["workspace"] = {
    -- Workspace movement
    { { modkey            }, "Left", "View not empty previous workspace", function() dynamo.misc.switch_occupied_tag(-1) end },
    { { modkey            }, "Right", "View not empty next workspace", function() dynamo.misc.switch_occupied_tag(1) end },
    { { modkey, altkey    }, "Left", "View previous workspace", awful.tag.viewprev },
    { { modkey, altkey    }, "Right", "View next workspace", awful.tag.viewnext },
    { { modkey            }, "Escape", "Go back to last workspace", awful.tag.history.restore },
  },
  ["window"] = {
    -- Client focus
    { { altkey            }, "Tab", "Focus to next window", function() awful.client.focus.byidx(1) end },
    { { altkey, "Shift"   }, "Tab", "Focus to previous window", function() awful.client.focus.byidx(-1) end },
    { { modkey            }, "u", "Focus to urgent window", awful.client.urgent.jumpto },
    -- Layout manipulation
    { { modkey, "Shift"   }, "j", "Swap to next window", function() awful.client.swap.byidx(1) end },
    { { modkey, "Shift"   }, "k", "Swap to previous window", function() awful.client.swap.byidx(-1) end },
    -- Restore client
    { { modkey, "Control" }, "n", "Select previous layout", restore_minimized_window },
  },
  ["layout"] = {
    { { modkey            }, "l", "Increase master width factor", function() awful.tag.incmwfact(0.05) end },
    { { modkey            }, "h", "Decrease master width factor", function() awful.tag.incmwfact(-0.05) end },
    { { modkey, "Shift"   }, "l", "Increase number of master windows", function() awful.tag.incnmaster(1, nil, true) end },
    { { modkey, "Shift"   }, "h", "Increase number of master windows", function() awful.tag.incnmaster(-1, nil, true) end },
    { { modkey, "Control" }, "l", "Increase number of column", function() awful.tag.incncol(1, nil, true) end },
    { { modkey, "Control" }, "h", "Increase number of column", function() awful.tag.incncol(-1, nil, true) end },
    { { modkey            }, "space", "Select next layout", function() awful.layout.inc(1) end },
    { { modkey, "Shift"   }, "space", "Select previous layout", function() awful.layout.inc(-1) end },
  },
  ["screen"] = {
    -- Panel
    { { modkey            }, "b", "Toggle panel", hide_panel },
    -- Screen focus
    { { modkey, "Control" }, "j", "Focus to next screen", function() awful.screen.focus_relative(1) end },
    { { modkey, "Control" }, "k", "Focus to previous screen", function() awful.screen.focus_relative(-1) end },
  },
  ["3rd app"] = {
    { { modkey            }, "Return", "Open a terminal", function() awful.spawn(terminal_tmux) end },
    { { modkey            }, "d", "Toggle color temperature (redshift)", dynamo.misc.redshift_toggle },
    { { modkey            }, "x", "Show clipboard list", function() awful.spawn(clipboard_list) end },
  }
}

-- Bind all key numbers to workspaces.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  table.merge(list_global_keys["workspace"], {
    -- View tag only.
    { { modkey            }, "#" .. i + 9, "View workspace #" .. i, function() action_workspace(i) end },
    -- Toggle tag display.
    { { modkey, "Control" }, "#" .. i + 9, "Toggle workspace #" .. i, function() action_workspace(i, awful.tag.viewtoggle) end },
    -- Move client to tag.
    { { modkey, "Shift"   }, "#" .. i + 9, "Move focused window to workspace #" .. i, function() if client.focus then action_workspace(i, function(tag) client.focus:move_to_tag(tag) end) end end },
    -- Toggle tag on focused client.
    { { modkey, "Control", "Shift" }, "#" .. i + 9, "Toggle focused window to workspace #" .. i, function() if client.focus then action_workspace(i, function(tag) client.focus:toggle_tag(tag) end) end end },
  })
end

-- Windows key
local list_window_keys = {
  { { altkey            }, "F4", "Close window", function(c) c:kill() end },
  { { modkey            }, "f", "Toggle fullscreen", function(c) c.fullscreen = not c.fullscreen; c:raise() end },
  { { modkey, "Control" }, "space", "Toggle floating", awful.client.floating.toggle },
  { { modkey, "Control" }, "Return", "Move to master", function(c) c:swap(awful.client.getmaster()) end },
  { { modkey            }, "o", "Move to other screen", function(c) c:move_to_screen() end },
  { { modkey            }, "t", "Toggle keep on top", function(c) c.ontop = not c.ontop end },
  { { modkey            }, "n", "Minimize window", function(c) c.minimized = true end },
  { { modkey            }, "m", "Toggle maximize window", function(c) c.maximized = not c.maximized; c:raise() end },
}
-- }

-- { Global key bindings
global_keys = {}
for group, list_group_keys in pairs(list_global_keys) do
  for _, group_keys in ipairs(list_group_keys) do
    table.merge(global_keys, awful.key(group_keys[1], group_keys[2], group_keys[4], { group = group, description = group_keys[3] }))
  end
end

-- Set keys
root.keys(global_keys)
-- }

-- { Window key bindings
window_keys = {}
for _, keys in ipairs(list_window_keys) do
  table.merge(window_keys, awful.key(keys[1], keys[2], keys[4], { group = "window", description = keys[3] }))
end
-- }
