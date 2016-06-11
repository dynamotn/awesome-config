-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Scratch drop
local drop = require("drop")
-- Vicious
local vicious = require("vicious")
-- Menubar
local menubar = require("menubar")

-- Global keys
globalkeys = awful.util.table.join(

    -- Workspace browsing
    awful.key({ modkey,           }, "Left",   function() dynamo.switch_tag(-1) end),
    awful.key({ modkey,           }, "Right",  function() dynamo.switch_tag( 1) end),
    awful.key({ altkey,           }, "Left",   awful.tag.viewprev                  ),
    awful.key({ altkey,           }, "Right",  awful.tag.viewnext                  ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore           ),

    -- Screen move
    awful.key({ modkey, "Control" }, "Left",   function() awful.screen.focus(mouse.screen - 1) end),
    awful.key({ modkey, "Control" }, "Right",  function() awful.screen.focus(mouse.screen + 1) end),

    -- Client focus
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show menu
    awful.key({ modkey,           }, "F2", function () mymainmenu:show() end),

    -- Show/Hide Wibox
    awful.key({ modkey,           }, "b",
        function ()
            mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
            mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ altkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal_tmux) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart                                ),
    awful.key({ modkey,           }, "i",      function () awful.util.spawn(file_manager)  end),
    awful.key({ modkey,           }, "q",      function () awful.util.spawn(browser)  end),
 
    -- Screenshot
    awful.key({                   }, "Print", function () os.execute(screenshot) end),
    awful.key({ altkey,           }, "Print", function () os.execute(screenshot .. ' -s') end),

    -- Prompt
    awful.key({ altkey,           }, "F2",    function () mypromptbox[mouse.screen]:run() end),
    awful.key({ altkey,           }, "F3",    dynamo.calculate                               ),
    awful.key({                   }, "XF86Launch1", dynamo.quote                             ),

    -- Touchpad
    awful.key({                   }, "XF86TouchpadToggle", dynamo.touchpad_toggle            ),

    -- ALSA volume control
    awful.key({                   }, "XF86AudioRaiseVolume",
    function ()
        awful.util.spawn("amixer -q set Master 1%+")
        vicious.force({vol.text})
    end),
    awful.key({                   }, "XF86AudioLowerVolume",
    function ()
        awful.util.spawn("amixer -q set Master 1%-")
        vicious.force({vol.text})
    end),
    awful.key({                   }, "XF86AudioMute",
    function ()
        awful.util.spawn("amixer -q set Master playback toggle")
        vicious.force({vol.text})
    end),
    awful.key({                   }, "XF86AudioMicMute",
    function ()
        awful.util.spawn("amixer -q set Capture toggle")
        vicious.force({vol.text})
    end),

    -- MPD control
    awful.key({                   }, "XF86AudioPlay",
    function ()
        awful.util.spawn_with_shell("mpc toggle")
        vicious.force({mpd.text})
    end),
    awful.key({                   }, "XF86AudioStop",
    function ()
        awful.util.spawn_with_shell("mpc stop")
        vicious.force({mpd.text})
    end),
    awful.key({                   }, "XF86AudioPrev",
    function ()
        awful.util.spawn_with_shell("mpc prev")
        vicious.force({mpd.text})
    end),
    awful.key({                   }, "XF86AudioNext",
    function ()
        awful.util.spawn_with_shell("mpc next")
        vicious.force({mpd.text})
    end),

    -- Brightness control
    awful.key({                   }, "XF86MonBrightnessUp",
    function ()
        awful.util.spawn_with_shell("xbacklight -inc 10")
    end),
    awful.key({                   }, "XF86MonBrightnessDown",
    function ()
        awful.util.spawn_with_shell("xbacklight -dec 10")
    end),

    -- Application

    -- Dropdown terminal
    awful.key({ modkey,           }, "z",     function () drop(terminal)  end),

    -- Redshift
    awful.key({ modkey,           }, "d",     redshift.toggle                ),

    -- Menubar
    awful.key({ modkey,           }, "p",     function () menubar.show()  end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ altkey,           }, "F4",     function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

-- Set keys
root.keys(globalkeys)
