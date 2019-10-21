-- AwesomeWM standard library
local awful = require("awful")
-- Table utilities library
local table = require("gears.table")
-- Popup library
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")
-- Custom libray
local dynamo = require("dynamo")

-- { Global key bindings
global_keys = table.join(
  -- Common
  awful.key({ modkey }, "s",
    hotkeys_popup.show_help,
    { group = "awesome", description = "show help" }),
  awful.key({ modkey, "Control" }, "r",
    awesome.restart,
    { group = "awesome", description = "reload awesome" }),
  awful.key({ modkey, "Shift" }, "q",
    awesome.quit,
    { group = "awesome", description = "quit awesome" }),

  -- Prompt
  awful.key({ altkey }, "F1",
    dynamo.notify.xprop,
    { group = "awesome", description = "show properties of window" }),
  awful.key({ altkey }, "F2",
    function()
      if not dynamo_prompt.is_busy then
        awful.screen.focused().prompt_box:run()
      end
    end,
    { group = "awesome", description = "run command" }),
  awful.key({ altkey }, "F3",
    dynamo.notify.calculation,
    { group = "awesome", description = "calculation" }),

  -- Menu
  awful.key({ modkey }, "F1",
    function() main_menu:show() end,
    { group = "awesome", description = "show main menu" }),
  awful.key({ modkey }, "F2",
    function() menubar.show() end,
    { group = "awesome", description = "show the menubar" }),

  -- Workspace movement
  awful.key({ modkey }, "Left",
    function() dynamo.misc.switch_occupied_tag(-1) end,
    { group = "workspace", description = "view not empty previous" }),
  awful.key({ modkey }, "Right",
    function() dynamo.misc.switch_occupied_tag(1) end,
    { group = "workspace", description = "view not empty next" }),
  awful.key({ modkey, altkey }, "Left",
    awful.tag.viewprev,
    { group = "workspace", description = "view previous" }),
  awful.key({ modkey, altkey }, "Right",
    awful.tag.viewnext,
    { group = "workspace", description = "view next" }),
  awful.key({ modkey }, "Escape",
    awful.tag.history.restore,
    { group = "workspace", description = "go back" }),

  -- Client focus
  awful.key({ altkey}, "Tab",
    function() awful.client.focus.byidx(1) end,
    { group = "window", description = "focus next by index" }),
  awful.key({ altkey, "Shift"}, "Tab",
    function() awful.client.focus.byidx(-1) end,
    { group = "window", description = "focus previous by index" }),
  awful.key({ modkey }, "u",
    awful.client.urgent.jumpto,
    { group = "window", description = "jump to urgent window" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j",
    function() awful.client.swap.byidx( 1) end,
    { group = "window", description = "swap with next window by index" }),
  awful.key({ modkey, "Shift" }, "k",
    function() awful.client.swap.byidx( -1) end,
    { group = "window", description = "swap with previous window by index" }),
  awful.key({ modkey, "Control" }, "j",
    function() awful.screen.focus_relative( 1) end,
    { group = "screen", description = "focus the next screen" }),
  awful.key({ modkey, "Control" }, "k",
    function() awful.screen.focus_relative(-1) end,
    { group = "screen", description = "focus the previous screen" }),

  -- Panel
  awful.key({ modkey }, "b",
    function()
      local screen = awful.screen.focused()
      screen.top_wibox.visible = not screen.top_wibox.visible
      screen.bottom_wibox.visible = not screen.bottom_wibox.visible
    end,
    { group = "screen", description = "toggle panel" }),

  -- Layout
  awful.key({ modkey }, "l",
    function() awful.tag.incmwfact( 0.05) end,
    { group = "layout", description = "increase master width factor" }),
  awful.key({ modkey }, "h",
    function() awful.tag.incmwfact(-0.05) end,
    { group = "layout", description = "decrease master width factor" }),
  awful.key({ modkey, "Shift" }, "h",
    function() awful.tag.incnmaster( 1, nil, true) end,
    { group = "layout", description = "increase the number of master windows" }),
  awful.key({ modkey, "Shift" }, "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { group = "layout", description = "decrease the number of master windows" }),
  awful.key({ modkey, "Control" }, "h",
    function() awful.tag.incncol( 1, nil, true) end,
    { group = "layout", description = "increase the number of columns" }),
  awful.key({ modkey, "Control" }, "l",
    function() awful.tag.incncol(-1, nil, true) end,
    { group = "layout", description = "decrease the number of columns" }),
  awful.key({ modkey }, "space",
    function() awful.layout.inc( 1) end,
    { group = "layout", description = "select next" }),
  awful.key({ modkey, "Shift" }, "space",
    function() awful.layout.inc(-1) end,
    { group = "layout", description = "select previous" }),
  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
          )
      end
    end,
    { group = "window", description = "restore minimized" }),

  -- Third party application
  awful.key({ modkey }, "Return",
    function() awful.spawn(terminal_tmux) end,
    { group = "3rd apps", description = "open a terminal" }),
  awful.key({ modkey }, "d",
    dynamo.misc.redshift_toggle,
    { group = "3rd apps", description = "toggle color temperature (redshift)" }),
  awful.key({ modkey }, "x",
    function() awful.spawn(clipboard_list) end,
    { group = "3rd apps", description = "show clipboard list" })
  )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  global_keys = table.join(global_keys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { group = "workspace", description = "view workspace #"..i }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { group = "workspace", description = "toggle workspace #" .. i }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { group = "workspace", description = "move focused window to workspace #"..i }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { group = "workspace", description = "toggle focused window on workspace #" .. i })
    )
end

-- Set keys
root.keys(global_keys)
-- }

-- { Window key bindings
window_keys = table.join(
  awful.key({ modkey }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { group = "window", description = "toggle fullscreen" }),
  awful.key({ altkey }, "F4",
    function(c) c:kill() end,
    { group = "window", description = "close" }),
  awful.key({ modkey, "Control" }, "space",
    awful.client.floating.toggle,
    { group = "window", description = "toggle floating" }),
  awful.key({ modkey, "Control" }, "Return",
    function(c) c:swap(awful.client.getmaster()) end,
    { group = "window", description = "move to master" }),
  awful.key({ modkey }, "o",
    function(c) c:move_to_screen() end,
    { group = "window", description = "move to screen" }),
  awful.key({ modkey }, "t",
    function(c) c.ontop = not c.ontop end,
    { group = "window", description = "toggle keep on top" }),
  awful.key({ modkey }, "n",
    function(c) c.minimized = true end ,
    { group = "window", description = "minimize" }),
  awful.key({ modkey }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    { group = "window", description = "(un)maximize" })
  )
-- }
