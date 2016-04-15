-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- Set urxvt transparent
    { rule = { class = "urxvt" },
      properties = { opacity = 0.1 } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[screen.count()][2] } },
    -- Plugin of firefox must be floating window
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    -- DownThemAll Manager must be floating window
    { rule = { instance = "DTA" },
      properties = { floating = true } },
    -- mpv must be floating window
    { rule = { class = "mpv" },
      properties = { floating = true } },
}
