-- AwesomeWM standard library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = window_keys,
      buttons = window_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      maximized_horizontal = false,
      maximized_vertical = false,
      size_hints_honor = false,
      opacity = 1,
      titlebars_enabled = true,
    }
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll
        "copyq",  -- CopyQ clipboard manager
        "nm-connection-editor", -- Network Manager GUI
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar
        "ConfigManager",  -- Thunderbird's about:config
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools
        "GtkFileChooserDialog", -- File Chooser dialog
      },
      class = {
        "mpv"
      },
      type = {
        "dialog"
      }
    },
    properties = { floating = true }
  },

  -- Set Firefox to always map on tags number 2 of primary screen
  {
    rule_any = { class = { "Firefox", "firefox" } },
    except = { type = "dialog" },
    properties = { screen = "primary", tag = web_workspace }
  },
  -- Set KeepassXC to always maps on tags number 9 of last screen
  {
    rule = { class = "keepassxc", type = "normal" },
    properties = { screen = screen.count(), tag = other_workspace }
  },
  -- Set Desktop of Gnome must be share all workspace
  {
    rule = { class = "Nautilus", instance = "desktop_window" },
    properties = { sticky = true }
  },
  -- Set File manager of Gnome to always map on tags number 8 of primary screen
  {
    rule = { class = "Nautilus", instance = "nautilus" },
    properties = { screen = "primary", tag = sys_workspace }
  },
  -- Set Zim to always maps on tags number 6 of last screen
  {
    rule = { class = "Zim", type = "normal" },
    properties = { screen = screen.count(), tag = doc_workspace }
  },
  -- Set WPS Office to always maps on tags number 6 of primary screen
  {
    rule_any = { class = { "Wps", "Et", "Wpspdf", "Wpp" } },
    properties = { screen = "primary", tag = doc_workspace }
  },
  -- Set Steam to always map on tags number 7 of primary screen
  {
    rule = { class = "Steam" },
    properties = { screen = "primary", tag = game_workspace }
  },
}
