-- AwesomeWM standard library
local awful = require('awful')
-- Bling library
local bling = require('bling')
-- Theme handling library
local beautiful = require('beautiful')
-- Configuration
local apps = require('config.apps')

local M = {}

local create_widget = function(args)
  local attrs = {
    sticky = true,
    autoclose = false,
    floating = true,
    geometry = {
      x = 0,
      y = beautiful.top_panel_height,
      height = (awful.screen.focused().geometry.height - beautiful.top_panel_height - beautiful.bottom_panel_height)
        / 2,
      width = awful.screen.focused().geometry.width,
    },
    reapply = true,
    dont_focus_before_close = false,
  }
  for k, v in pairs(args) do
    attrs[k] = v
  end

  return bling.module.scratchpad(attrs)
end

M.monitor = create_widget({
  command = apps.system_monitor_cmd,
  rule = { instance = 'dynamo_monitor' },
})

M.gpu = create_widget({
  command = apps.gpu_monitor_cmd,
  rule = { instance = 'dynamo_gpu' },
  geometry = {
    x = 0,
    y = beautiful.top_panel_height,
    height = (awful.screen.focused().geometry.height - beautiful.top_panel_height - beautiful.bottom_panel_height)
      / 3
      * 2,
    width = awful.screen.focused().geometry.width,
  },
})

M.music = create_widget({
  command = apps.music_player_cmd,
  rule = { instance = 'dynamo_music' },
})

M.terminal = create_widget({
  command = apps.quake_cmd,
  rule = { instance = 'dynamo_kittuake' },
})

return M
