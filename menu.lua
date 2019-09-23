-- AwesomeWM standard library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

-- Create a launcher widget and a main menu
myawesomemenu = {
  { "Hot&keys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "Edit &configuration", editor_cmd .. " " .. awesome.conffile },
  { "&Restart", awesome.restart },
}

mysystemmenu = {
}

mymainmenu = awful.menu({items = {
      { "&Awesome", myawesomemenu, beautiful.awesome_icon },
      { "&System", mysystemmenu },
  }})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
