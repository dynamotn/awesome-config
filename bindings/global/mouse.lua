-- AwesomeWM standard library
local awful = require('awful')
-- Table utilities library
local table = require('gears.table')
-- Special keys
local k = require('bindings.special').key
local m = require('bindings.special').mouse
-- Widgets
local widgets = require('widgets')

local list = {
  ['workspace'] = {
    {
      {},
      m.left,
      function(t)
        t:view_only()
      end,
    },
    {
      { k.super },
      m.left,
      function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end,
    },
    {
      {},
      m.right,
      awful.tag.viewtoggle,
    },
    {
      { k.super },
      m.right,
      function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end,
    },
    {
      {},
      m.up,
      function(t)
        awful.tag.viewnext(t.screen)
      end,
    },
    {
      {},
      m.down,
      function(t)
        awful.tag.viewprev(t.screen)
      end,
    },
  },
  ['taskbar'] = {
    {
      {},
      m.left,
      function(c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal('request::activate', 'tasklist', { raise = true })
        end
      end,
    },
    {
      {},
      m.right,
      function()
        awful.menu.client_list({ theme = { width = 250 } })
      end,
    },
    {
      {},
      m.up,
      function()
        awful.client.focus.byidx(1)
      end,
    },
    {
      {},
      m.down,
      function()
        awful.client.focus.byidx(-1)
      end,
    },
  },
  ['layout'] = {
    {
      {},
      m.left,
      function()
        awful.layout.inc(1)
      end,
    },
    {
      {},
      m.right,
      function()
        awful.layout.inc(-1)
      end,
    },
    {
      {},
      m.up,
      function()
        awful.layout.inc(1)
      end,
    },
    {
      {},
      m.down,
      function()
        awful.layout.inc(-1)
      end,
    },
  },
  ['desktop'] = {
    {
      {},
      m.right,
      function()
        widgets.menu:toggle()
      end,
    },
    {
      {},
      m.up,
      awful.tag.viewnext,
    },
    {
      {},
      m.down,
      awful.tag.viewprev,
    },
  },
}

local global_mousebindings = {}
for group, mousebindings in pairs(list) do
  global_mousebindings[group] = {}
  for _, mousebinding in ipairs(mousebindings) do
    table.merge(global_mousebindings[group], awful.button(mousebinding[1], mousebinding[2], mousebinding[3]))
  end
end

return global_mousebindings
