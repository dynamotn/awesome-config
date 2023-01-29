-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Special keys
local m = require('bindings.special').mouse
-- Custom library
local scratchpad = require('widgets.scratchpad')

local list = {
  {
    {},
    m.left,
    function()
      scratchpad.music:toggle()
    end,
  },
}

local widget_mousebindings = {}
for _, mousebinding in ipairs(list) do
  table.merge(widget_mousebindings, awful.button(mousebinding[1], mousebinding[2], mousebinding[3]))
end

return widget_mousebindings
