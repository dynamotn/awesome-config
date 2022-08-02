-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Special keys
local k = require('bindings.special').key
local m = require('bindings.special').mouse

local list = {
  {
    {},
    m.left,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end,
  },
  {
    { k.super },
    m.left,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
      awful.mouse.client.move(c)
    end,
  },
  {
    { k.super },
    m.right,
    function(c)
      c:emit_signal('request::activate', 'mouse_click', { raise = true })
      awful.mouse.client.resize(c)
    end,
  },
}

local window_mousebindings = {}
for _, mousebinding in ipairs(list) do
  table.merge(window_mousebindings, awful.button(mousebinding[1], mousebinding[2], mousebinding[3]))
end

return window_mousebindings
