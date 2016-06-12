-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Lua to HTML library
local html = require("html")
-- Vicious library
local vicious = require("vicious")
vicious.contrib = require("vicious.contrib")
-- Widget and layout library
local wibox = require("wibox")

local index_indicator = 0
local index_widget = 0

-- {{{ MPD
mpd = dynamo.section(beautiful.widget_music_off, cyclic(beautiful.bg_indicator, index_indicator), cyclic(beautiful.bg_indicator, index_indicator + 1))
vicious.register(mpd.text, vicious.widgets.mpd,
                 function(widget, args)
                     if args["{state}"] == "Play" then
                         mpd.icon:set_widget(wibox.widget.imagebox(beautiful.widget_music_on))
                         return html(beautiful.fg_artist, " " .. args["{Artist}"] .. " ") .. args["{Title}"] .. " "
                     elseif args["{state}"] == "Pause" then
                         mpd.icon:set_widget(wibox.widget.imagebox(beautiful.widget_music_off))
                         return "Pause "
                     else
                         mpd.icon:set_widget(wibox.widget.imagebox(beautiful.widget_music_off))
                         return "Stop "
                     end
                 end, 2)
mpd:buttons(mpdbuttons)
index_indicator = index_indicator + 1
-- }}}

-- {{{ Volume
vol = dynamo.section(beautiful.widget_vol, cyclic(beautiful.bg_indicator, index_indicator), cyclic(beautiful.bg_indicator, index_indicator + 1))
vicious.register(vol.text, vicious.widgets.volume,
                 function(widget, args)
                     if args[2] == "♩" then
                         vol.icon:set_widget(wibox.widget.imagebox(beautiful.widget_vol_mute))
                     elseif args[1] == 0 then
                         vol.icon:set_widget(wibox.widget.imagebox(beautiful.widget_vol_no))
                     elseif args[1] <= 50 then
                         vol.icon:set_widget(wibox.widget.imagebox(beautiful.widget_vol_low))
                     else
                         vol.icon:set_widget(wibox.widget.imagebox(beautiful.widget_vol))
                     end
                     return args[1] .. " "
                 end, 2, "Master")
index_indicator = index_indicator + 1
-- }}}

-- {{{ Memory
mem = dynamo.section(beautiful.widget_mem, cyclic(beautiful.bg_indicator, index_indicator), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(mem.text, vicious.widgets.mem, html(cyclic(beautiful.fg_widget, index_widget + 1), "$2MB "), 2)
index_widget = index_widget + 1
-- }}}

-- {{{ CPU
cpu = dynamo.section(beautiful.widget_cpu, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(cpu.text, vicious.widgets.cpu, html(cyclic(beautiful.fg_widget, index_widget + 1), "$1% "), 2)
index_widget = index_widget + 1
-- }}}

-- {{{ Temperature
temp = dynamo.section(beautiful.widget_temp, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(temp.text, vicious.widgets.thermal, html(cyclic(beautiful.fg_widget, index_widget + 1), "$1°C "), 2, "thermal_zone0")
index_widget = index_widget + 1
-- }}}

-- {{{ Disk space
hdd = dynamo.section(beautiful.widget_hdd, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(hdd.text, vicious.widgets.fs, html(cyclic(beautiful.fg_widget, index_widget + 1), "${/home used_gb}GB "), 60)
index_widget = index_widget + 1
-- }}}

-- {{{ Power
bat = dynamo.section(beautiful.widget_bat, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
local battery_index = index_widget + 1
vicious.register(bat.text, vicious.widgets.bat,
                 function(widget, args)
                     if args[1] == "⌁" then
                         bat.icon:set_widget(wibox.widget.imagebox(beautiful.widget_battery_no))
                         return html(cyclic(beautiful.fg_widget, battery_index), "AC ")
                     elseif args[2] <= 5 then
                         bat.icon:set_widget(wibox.widget.imagebox(beautiful.widget_battery_empty))
                     elseif args[2] <= 15 then
                         bat.icon:set_widget(wibox.widget.imagebox(beautiful.widget_battery_low))
                     else
                         bat.icon:set_widget(wibox.widget.imagebox(beautiful.widget_battery_normal))
                         if args[1] == '↯' then
                             return html(cyclic(beautiful.fg_widget, battery_index), "Full ")
                         end
                     end
                     return html(cyclic(beautiful.fg_widget, battery_index), args[2] .. "% ")
                 end, 1, "BAT1")
index_widget = index_widget + 1
-- }}}

-- {{{ Network
net = dynamo.section(beautiful.widget_net, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(net.text, vicious.contrib.net, html(beautiful.fg_net_down, "${total down_kb}") .. " ↓↑ " .. html(beautiful.fg_net_up, "${total up_kb} "), 1)
index_widget = index_widget + 1
-- }}}

-- {{{ Clock
clock = dynamo.section(beautiful.widget_clock, cyclic(beautiful.bg_widget, index_widget), cyclic(beautiful.bg_widget, index_widget + 1))
vicious.register(clock.text, vicious.widgets.date, html(beautiful.fg_hour, " %I:%M %p ") .. html(beautiful.fg_date," %a %d %b "), 10)
index_widget = index_widget + 1
-- }}}

-- {{{ Prompt
prompt = {}
prompt.text = wibox.widget.textbox()
prompt.info = wibox.widget.background(prompt.text, beautiful.bg_command)
prompt.arrow = dynamo.arrow_right(beautiful.bg_command, beautiful.bg_normal)
launcher = wibox.widget.background(mylauncher, beautiful.bg_command)
dynamo.prompt()
-- }}}

-- {{{ Miscelaneous
space = wibox.widget.textbox(' ')
layoutarrow = dynamo.arrow_left(cyclic(beautiful.bg_widget, index_widget), beautiful.bg_indicator[1])
startarrow = dynamo.arrow_border_left(beautiful.bg_indicator[1])
-- }}}

-- {{{ Create a wibox for each screen and add it
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ prompt = "" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(layoutbuttons)
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons, nil, dynamo.update_taglist)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, nil, dynamo.update_tasklist)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = beautiful.top_panel_height })
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, height = beautiful.bottom_panel_height })

    -- Top left panel
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(launcher)
    left_layout:add(prompt.info)
    left_layout:add(prompt.arrow)
    left_layout:add(space)
    left_layout:add(mypromptbox[s])

    -- Top right panel
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(startarrow)
    right_layout:add(space)
    if s == screen.count() then
        right_layout:add(wibox.widget.systray())
        right_layout:add(space)
    end
    right_layout:add(startarrow)
    right_layout:add(mpd.arrow)
    right_layout:add(mpd.icon)
    right_layout:add(mpd.info)
    right_layout:add(vol.arrow)
    right_layout:add(vol.icon)
    right_layout:add(vol.info)
    right_layout:add(mem.arrow)
    right_layout:add(mem.icon)
    right_layout:add(mem.info)
    right_layout:add(cpu.arrow)
    right_layout:add(cpu.icon)
    right_layout:add(cpu.info)
    right_layout:add(temp.arrow)
    right_layout:add(temp.icon)
    right_layout:add(temp.info)
    right_layout:add(hdd.arrow)
    right_layout:add(hdd.icon)
    right_layout:add(hdd.info)
    right_layout:add(bat.arrow)
    right_layout:add(bat.icon)
    right_layout:add(bat.info)
    right_layout:add(net.arrow)
    right_layout:add(net.icon)
    right_layout:add(net.info)
    right_layout:add(clock.arrow)
    right_layout:add(clock.icon)
    right_layout:add(clock.info)
    right_layout:add(layoutarrow)
    right_layout:add(mylayoutbox[s])

    -- Top panel
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

    -- Bottom right panel
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(mytasklist[s])

    -- Bottom panel with left is tag list
    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(mytaglist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}
