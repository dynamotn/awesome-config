-- AwesomeWM standard library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
-- Menubar library
local utils = require("menubar.utils")

-- Create a launcher widget and a main menu
local awesome_menu = {
  { "Hot&keys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "Edit &configuration", editor_cmd .. " " .. awesome.conffile, beautiful.menu_edit_icon },
  { "&Restart", awesome.restart, beautiful.menu_restart_icon },
}

local system_menu = {
}

main_menu = awful.menu({items = {
      { "&Awesome", awesome_menu, beautiful.awesome_icon },
      { "&System", system_menu, utils.lookup_icon("applications-system") },
  }})

launcher = awful.widget.launcher({ image = beautiful.launcher_icon, menu = main_menu })
