-- AwesomeWM standard library
local awful = require('awful')
-- Configuration
local layouts = require('config.layouts')

tag.connect_signal('request::default_layouts', function()
  awful.layout.append_default_layouts(layouts)
end)
