-- AwesomeWM standard library
local awful = require("awful")
-- Table utilities library
local table = require("gears.table")

-- { Workspace buttons
taglist_buttons = table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )
-- }

-- { Taskbar buttons
tasklist_buttons = table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
        )
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
  end)
  )
-- }

-- { Window buttons
clientbuttons = table.join(
  awful.button({ }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
  )
-- }

-- { Layout box buttons
layoutbuttons = table.join(
  awful.button({ }, 1, function() awful.layout.inc( 1) end),
  awful.button({ }, 3, function() awful.layout.inc(-1) end),
  awful.button({ }, 4, function() awful.layout.inc( 1) end),
  awful.button({ }, 5, function() awful.layout.inc(-1) end)
  )
-- }

-- { Desktop buttons
root.buttons(table.join(
    awful.button({ }, 3, function() dynamo_main_menu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
  ))
-- }
