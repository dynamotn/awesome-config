-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Special keys
local m = require('bindings.special').mouse
-- Custom library
local misc = require('dynamo.misc')

local list = {
  {
    {},
    m.left,
    function()
      misc.run_at_workspace(music_cmd, music_workspace)
    end,
  },
}

local widget_mousebindings = {}
for _, mousebinding in ipairs(list) do
  table.merge(widget_mousebindings, awful.button(mousebinding[1], mousebinding[2], mousebinding[3]))
end

return widget_mousebindings
