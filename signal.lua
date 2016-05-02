-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    --Fix some weird reload bugs
    if c.size_hints.user_size and startup then
        c:geometry({width = c.size_hints.user_size.width,height = c.size_hints.user_size.height, x = c:geometry().x})
    end
    if c.size_hints.max_height and c.size_hints.max_height < screen[c.screen].geometry.height / 2 then
        awful.client.setslave(c)
    end

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- No border for maximized clients
client.connect_signal("focus", function(c)
    if c.maximized_horizontal == true and c.maximized_vertical == true then
        c.border_width = 0
        c.border_color = beautiful.border_normal
    else
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end)

client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    if #clients > 0 then -- Fine grained borders and floaters control
        for _, c in pairs(clients) do -- Floaters always have borders
            if awful.client.floating.get(c) or layout == "floating" then
                c.border_width = beautiful.border_width

                -- No borders with only one visible client
            elseif #clients == 1 or layout == "max" then
                clients[1].border_width = 0
            else
                c.border_width = beautiful.border_width
            end
        end
    end
end)
end
