-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Lua to HTML library
local html = require("html")
-- Vicious library
local vicious = require("vicious")
-- Widget and layout library
local wibox = require("wibox")

local i = 0

-- MEM
mem = dynamo.section(beautiful.widget_mem, "opaque", beautiful.bg_widget[i + 1])
vicious.register(mem.text, vicious.widgets.mem, html(beautiful.fg_mem, "$2MB "), 3)
i = i + 1

-- Clock
clock = dynamo.section(beautiful.widget_clock, beautiful.bg_widget[i], beautiful.bg_widget[i + 1])
vicious.register(clock.text, vicious.widgets.date, html(beautiful.fg_hour, " %H:%M ") .. html(beautiful.fg_date," %a %d %b "))
i = i + 1

space = wibox.widget.textbox(' ')
layoutarrow = dynamo.arrow_left(beautiful.bg_widget[i], "#313131") 
-- Create a wibox for each screen and add it

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ prompt = html(beautiful.fg_command, "Lệnh: ") })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(layoutbuttons)
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = beautiful.top_panel_height })
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, height = beautiful.bottom_panel_height })

    -- Top left panel
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(space)
    left_layout:add(mypromptbox[s])

    -- Top right panel
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mem.arrow)
    right_layout:add(mem.icon)
    right_layout:add(mem.info)
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
