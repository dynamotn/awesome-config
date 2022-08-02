-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Special keys
local k = require('bindings.special').key

local list = {
  {
    { k.alt },
    'F4',
    'Close window',
    function(c)
      c:kill()
    end,
  },
  {
    { k.super },
    'f',
    'Toggle fullscreen',
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
  },
  {
    { k.super, k.ctrl },
    'space',
    'Toggle floating',
    awful.client.floating.toggle,
  },
  {
    { k.super, k.ctrl },
    'Return',
    'Move to master',
    function(c)
      c:swap(awful.client.getmaster())
    end,
  },
  {
    { k.super },
    'o',
    'Move to other screen',
    function(c)
      c:move_to_screen()
    end,
  },
  {
    { k.super },
    't',
    'Toggle keep on top',
    function(c)
      c.ontop = not c.ontop
    end,
  },
  {
    { k.super },
    'n',
    'Minimize window',
    function(c)
      c.minimized = true
    end,
  },
  {
    { k.super },
    'm',
    'Toggle maximize window',
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
  },
}

local window_keybindings = {}
for _, keybinding in ipairs(list) do
  table.merge(
    window_keybindings,
    awful.key({
      modifiers = keybinding[1],
      key = keybinding[2],
      description = keybinding[3],
      group = 'window',
      on_press = keybinding[4],
      keygroup = keybinding['keygroup'],
    })
  )
end

return window_keybindings
