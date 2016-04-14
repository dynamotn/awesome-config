-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Lua to HTML library
local html = require("html")
-- Vicious library
local vicious = require("vicious")
-- Widget and layout library
local wibox = require("wibox")

-- Create a textclock widget
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
clockwidget = wibox.widget.textbox()
vicious.register(clockwidget, vicious.widgets.date, html("#de5e1e", "%H:%M ") .. html("#7788af"," %a %d %b"))

-- MEM
memicon = wibox.widget.background()
memicon.icon = wibox.widget.imagebox(beautiful.widget_mem)
memicon:set_bg("#777e76")
memicon:set_widget(memicon.icon)
memwidget = wibox.widget.background()
memwidget.text = wibox.widget.textbox()
memwidget:set_bg("#777e76")
memwidget:set_widget(memwidget.text)
vicious.register(memwidget.text, vicious.widgets.mem, html("#eeeeee", "$2MB"), 3)

-- Create a wibox for each screen and add it

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ prompt = html(beautiful.fg_command, "Lệnh: ") })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
                           ))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18 })
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, height = 25 })

    -- Top left panel
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mypromptbox[s])

    -- Top right panel
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(clockwidget)
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
