-- AwesomeWM standard library
local awful = require('awful')
-- Notification library
local naughty = require('naughty')
-- Table utilities library
local table = require('gears.table')
-- Popup library
local hotkeys_popup = require('awful.hotkeys_popup')
-- Special keys
local k = require('bindings.special').key
-- Configuration
local apps = require('config.apps')
-- Custom library
local notify = require('lib.notify')
local session = require('lib.session')
local redshift = require('lib.redshift')
local workspace = require('lib.workspace')
local menu = require('widgets.menu')
local scratchpad = require('widgets.scratchpad')

local list = {
  ['awesome'] = {
    -- Common
    {
      { k.super },
      's',
      'Show help',
      hotkeys_popup.show_help,
    },
    {
      { k.super, k.ctrl },
      'r',
      'Reload awesome',
      awesome.restart,
    },
    {
      { k.super, k.shift },
      'q',
      'Quit',
      awesome.quit,
    },
    {
      { k.super },
      'q',
      'Lock',
      session.lock,
    },
    {
      { k.super, k.ctrl },
      'q',
      'Disable/enable lockscreen timeout',
      function()
        if _G.disabled_lockscreen == nil then
          _G.disabled_lockscreen = 1
          naughty.notify({ text = 'Disable lockscreen timeout' })
          os.execute('xset s off')
        else
          _G.disabled_lockscreen = nil
          naughty.notify({ text = 'Enable lockscreen timeout' })
          os.execute('xset s ' .. require('config.common').screen_saver_timeout)
        end
      end,
    },
    -- Prompt
    {
      { k.alt },
      'F1',
      'Show properties of window',
      notify.xprop,
    },
    {
      { k.alt },
      'F2',
      'Run command',
      function()
        awful.spawn(apps.command_launcher)
      end,
    },
    {
      { k.alt },
      'F3',
      'Calculation',
      function()
        awful.spawn(apps.calculator_launcher)
      end,
    },
    -- Menu
    {
      { k.super },
      'F1',
      'Show main menu',
      function()
        menu:show()
      end,
    },
    {
      { k.super },
      'F2',
      'Show menubar',
      function()
        awful.spawn(apps.application_launcher)
      end,
    },
  },
  ['workspace'] = {
    -- Workspace movement
    {
      { k.super },
      'Left',
      'View not empty previous workspace',
      function()
        workspace.switch_occupied_tag(-1)
      end,
    },
    {
      { k.super },
      'Right',
      'View not empty next workspace',
      function()
        workspace.switch_occupied_tag(1)
      end,
    },
    {
      { k.super, k.alt },
      'Left',
      'View previous workspace',
      awful.tag.viewprev,
    },
    {
      { k.super, k.alt },
      'Right',
      'View next workspace',
      awful.tag.viewnext,
    },
    {
      { k.super },
      'Escape',
      'Go back to last workspace',
      awful.tag.history.restore,
    },
    {
      { k.super },
      nil,
      'View workspace',
      function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          tag:view_only()
        end
      end,
      keygroup = 'numrow',
    },
    {
      { k.super, k.ctrl },
      nil,
      'Toggle workspace',
      function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      keygroup = 'numrow',
    },
    {
      { k.super, k.shift },
      nil,
      'Move focused window to workspace',
      function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      keygroup = 'numrow',
    },
    {
      { k.super, k.ctrl, k.shift },
      nil,
      'Toggle focused window to workspace',
      function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      keygroup = 'numrow',
    },
  },
  ['window'] = {
    -- Client focus
    {
      { k.alt },
      'Tab',
      'Focus to next window',
      function()
        awful.client.focus.byidx(1)
      end,
    },
    {
      { k.alt, k.shift },
      'Tab',
      'Focus to previous window',
      function()
        awful.client.focus.byidx(-1)
      end,
    },
    {
      { k.super },
      'u',
      'Focus to urgent window',
      awful.client.urgent.jumpto,
    },
    -- Layout manipulation
    {
      { k.super, k.shift },
      'j',
      'Swap to next window',
      function()
        awful.client.swap.byidx(1)
      end,
    },
    {
      { k.super, k.shift },
      'k',
      'Swap to previous window',
      function()
        awful.client.swap.byidx(-1)
      end,
    },
    -- Restore client
    {
      { k.super, k.ctrl },
      'n',
      'Select previous layout',
      function()
        local c = awful.client.restore()
        if c then
          c:emit_signal('request::activate', 'key.unminimize', { raise = true })
        end
      end,
    },
  },
  ['layout'] = {
    {
      { k.super },
      'l',
      'Increase master width factor',
      function()
        awful.tag.incmwfact(0.05)
      end,
    },
    {
      { k.super },
      'h',
      'Decrease master width factor',
      function()
        awful.tag.incmwfact(-0.05)
      end,
    },
    {
      { k.super, k.shift },
      'l',
      'Increase number of master windows',
      function()
        awful.tag.incnmaster(1, nil, true)
      end,
    },
    {
      { k.super, k.shift },
      'h',
      'Increase number of master windows',
      function()
        awful.tag.incnmaster(-1, nil, true)
      end,
    },
    {
      { k.super, k.ctrl },
      'l',
      'Increase number of column',
      function()
        awful.tag.incncol(1, nil, true)
      end,
    },
    {
      { k.super, k.ctrl },
      'h',
      'Increase number of column',
      function()
        awful.tag.incncol(-1, nil, true)
      end,
    },
    {
      { k.super },
      'space',
      'Select next layout',
      function()
        awful.layout.inc(1)
      end,
    },
    {
      { k.super, k.shift },
      'space',
      'Select previous layout',
      function()
        awful.layout.inc(-1)
      end,
    },
  },
  ['screen'] = {
    -- Panel
    {
      { k.super },
      'b',
      'Toggle panel',
      function()
        local screen = awful.screen.focused()
        screen.top_wibox.visible = not screen.top_wibox.visible
        screen.bottom_wibox.visible = not screen.bottom_wibox.visible
      end,
    },
    -- Screen focus
    {
      { k.super, k.ctrl },
      'j',
      'Focus to next screen',
      function()
        awful.screen.focus_relative(1)
      end,
    },
    {
      { k.super, k.ctrl },
      'k',
      'Focus to previous screen',
      function()
        awful.screen.focus_relative(-1)
      end,
    },
  },
  ['3rd app'] = {
    {
      { k.super },
      'Return',
      'Open a terminal',
      function()
        awful.spawn(apps.startup_terminal)
      end,
    },
    {
      { k.super },
      'd',
      'Toggle color temperature (redshift)',
      redshift.toggle,
    },
    {
      { k.super },
      'z',
      'Show Kittuake',
      function()
        scratchpad.terminal:toggle()
      end,
    },
    {
      { k.super },
      't',
      'Show monitor terminal',
      function()
        scratchpad.monitor:toggle()
      end,
    },
    {
      { k.super },
      'g',
      'Show GPU detail terminal',
      function()
        scratchpad.gpu:toggle()
      end,
    },
    {
      { k.super },
      'c',
      'Show music player',
      function()
        scratchpad.music:toggle()
      end,
    },
    {
      {},
      'XF86Mail',
      'Open email client',
      function()
        awful.spawn(apps.email_client)
      end,
    },
    {
      {},
      'XF86Explorer',
      'Open application launcher',
      function()
        awful.spawn(apps.application_launcher)
      end,
    },
    {
      { k.super },
      'x',
      'Show password list of Personal to insert input',
      function()
        awful.spawn.with_shell(apps.password_launcher)
      end,
    },
    {
      { k.super },
      'r',
      'Show password list of Enterprise to insert input',
      function()
        awful.spawn.with_shell(apps.password2_launcher)
      end,
    },
  },
  ['multimedia'] = {
    {
      {},
      'XF86AudioPlay',
      'Play song on mpd',
      function()
        awful.spawn(apps.music_play_cmd)
      end,
    },
    {
      {},
      'XF86AudioStop',
      'Stop mpd',
      function()
        awful.spawn(apps.music_stop_cmd)
      end,
    },
    {
      {},
      'XF86AudioPause',
      'Pause mpd',
      function()
        awful.spawn(apps.music_pause_cmd)
      end,
    },
    {
      {},
      'XF86AudioNext',
      'Next song',
      function()
        awful.spawn(apps.music_next_cmd)
      end,
    },
    {
      {},
      'XF86AudioPrev',
      'Previous music',
      function()
        awful.spawn(apps.music_previous_cmd)
      end,
    },
    {
      {},
      'XF86AudioRaiseVolume',
      'Increase volume',
      function()
        awful.spawn(apps.volume_raise_cmd)
      end,
    },
    {
      {},
      'XF86AudioLowerVolume',
      'Decrease volume',
      function()
        awful.spawn(apps.volume_lower_cmd)
      end,
    },
    {
      {},
      'XF86AudioMute',
      'Mute volume',
      function()
        awful.spawn(apps.volume_mute_cmd)
      end,
    },
  },
}

local global_keybindings = {}
for group, group_keybindings in pairs(list) do
  for _, keybinding in ipairs(group_keybindings) do
    table.merge(
      global_keybindings,
      awful.key({
        modifiers = keybinding[1],
        key = keybinding[2],
        description = keybinding[3],
        group = group,
        on_press = function(...)
          --- @type fun(...)
          local on_call = keybinding[4]
          if not _G.is_lock then
            on_call(...)
          end
        end,
        keygroup = keybinding['keygroup'],
      })
    )
  end
end

return global_keybindings
