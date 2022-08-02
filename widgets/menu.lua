-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
-- Menubar library
local utils = require('menubar.utils')
-- Custom session library
local session = require('dynamo.session')

-- Create a launcher widget and a main menu
local awesome_menu = {
  {
    'Hot&keys',
    function()
      awful.hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { 'Edit &configuration', editor_cmd .. ' ' .. awesome.conffile, beautiful.menu_edit_icon },
  { '&Restart', awesome.restart, beautiful.menu_restart_icon },
  { '&Quit session', session.quit },
}

local system_menu = {
  { '&Hibernate', session.hibernate },
  { '&Reboot', session.reboot },
  { '&Shutdown', session.shutdown },
  { 'S&chedule shutdown', session.schedule_shutdown },
}

return awful.menu({
  items = {
    { '&Awesome', awesome_menu, beautiful.awesome_icon },
    { '&System', system_menu, utils.lookup_icon('applications-system') },
  },
})
