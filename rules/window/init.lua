-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
-- Configuration
local workspaces = require('config.workspaces')

-- Find screen of a workspace by workspace name
-- @param name Name of the workspace
-- @return screen Screen of the workspace
local function find_screen_by_workspace_name(name)
  for _, tag in ipairs(root.tags()) do
    if tag.name == name then
      return tag.screen
    end
  end
  return 'primary'
end

return {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      maximized_horizontal = false,
      maximized_vertical = false,
      size_hints_honor = false,
      titlebars_enabled = true,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        'DTA', -- Firefox addon DownThemAll
        'copyq', -- CopyQ clipboard manager
        'nm-connection-editor', -- Network Manager GUI
        'Devtools', -- Firefox Developer Tools
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        'Event Tester', -- xev
      },
      role = {
        'AlarmWindow', -- Thunderbird's calendar
        'ConfigManager', -- Thunderbird's about:config
        'Msgcompose', -- Thunderbird's new sent email
        'pop-up', -- e.g. Google Chrome's (detached) Developer Tools
        'GtkFileChooserDialog', -- File Chooser dialog
      },
      class = {
        'mpv',
      },
      type = {
        'dialog',
      },
    },
    properties = { floating = true },
  },

  -- Set Firefox to always map on Web workspace
  {
    rule_any = { class = { 'Firefox', 'firefox' } },
    except = { type = 'dialog' },
    properties = { screen = find_screen_by_workspace_name(workspaces.web), tag = workspaces.web },
  },
  -- Set Thunderbird to always map on Mail workspace
  {
    rule_any = { class = { 'Thunderbird', 'thunderbird' }, instance = 'Mail' },
    properties = { screen = find_screen_by_workspace_name(workspaces.mail), tag = workspaces.mail },
  },
  -- Set Rambox, Ferdi, Telegram to always map on Chat workspace
  {
    rule_any = { class = { 'Rambox', 'Ferdi', 'TelegramDesktop' } },
    properties = { screen = find_screen_by_workspace_name(workspaces.chat), tag = workspaces.chat },
  },
  -- Set KeepassXC to always maps on More workspace
  {
    rule = { class = 'KeePassXC', type = 'normal' },
    properties = { screen = find_screen_by_workspace_name(workspaces.other), tag = workspaces.other },
  },
  -- Set Bitwarden Desktop to always maps on More workspace
  {
    rule = { class = 'Bitwarden', type = 'normal' },
    properties = { screen = find_screen_by_workspace_name(workspaces.other), tag = workspaces.other },
  },
  -- Set Desktop of Gnome must be share all workspace
  {
    rule = { class = 'Nautilus', instance = 'desktop_window' },
    properties = { sticky = true },
  },
  -- Set File manager of Gnome to always map on Sys workspace
  {
    rule = { class = 'Nautilus', instance = 'nautilus' },
    properties = { screen = find_screen_by_workspace_name(workspaces.sys), tag = workspaces.sys },
  },
  -- Set Zim to always maps on Doc workspace
  {
    rule = { class = 'Zim', type = 'normal' },
    properties = { screen = find_screen_by_workspace_name(workspaces.doc), tag = workspaces.doc },
  },
  -- Set WPS Office to always maps on Doc workspace
  {
    rule_any = { class = { 'Wps', 'Et', 'Wpspdf', 'Wpp' } },
    properties = { screen = find_screen_by_workspace_name(workspaces.doc), tag = workspaces.doc },
  },
  -- Set Steam to always map on tags number 7 of primary screen
  {
    rule = { class = 'Steam' },
    properties = { screen = find_screen_by_workspace_name(workspaces.game), tag = workspaces.game },
  },
}
