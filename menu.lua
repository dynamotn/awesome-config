-- AwesomeWM standard library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
-- Menubar library
local utils = require("menubar.utils")

-- Create a launcher widget and a main menu
dynamo_awesome_menu = {
  { "Hot&keys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "Edit &configuration", editor_cmd .. " " .. awesome.conffile, beautiful.menu_edit_icon },
  { "&Restart", awesome.restart, beautiful.menu_restart_icon },
}

dynamo_system_menu = {
}

dynamo_main_menu = awful.menu({items = {
      { "&Awesome", dynamo_awesome_menu, beautiful.awesome_icon },
      { "&System", dynamo_system_menu, utils.lookup_icon("applications-system") },
  }})

dynamo_launcher = awful.widget.launcher({ image = beautiful.launcher_icon, menu = dynamo_main_menu })
