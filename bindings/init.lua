-- AwesomeWM standard library
local awful = require('awful')

local config = {
  key = {
    global = require('bindings.global.key'),
    window = require('bindings.window.key'),
  },
  mouse = {
    global = require('bindings.global.mouse'),
    window = require('bindings.window.mouse'),
    widgets = {
      music = require('bindings.widgets.music'),
    },
  },
}

return {
  config = config,
  setup = function()
    root.keys(config.key.global)

    client.connect_signal('request::default_keybindings', function()
      awful.keyboard.append_client_keybindings(config.key.window)
    end)

    awful.mouse.append_global_mousebindings(config.mouse.global.desktop)

    client.connect_signal('request::default_mousebindings', function()
      awful.mouse.append_client_mousebindings(config.mouse.window)
    end)
  end,
}
