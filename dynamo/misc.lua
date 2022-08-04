-- AwesomeWM standard library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')
-- Wallpaper library
local wallpaper_lib = require('gears.wallpaper')
-- Custom shell library
local shell = require('dynamo.shell')
local markup_text = require('dynamo.string').markup_text

-- { Set wallpaper
-- Set random wallpaper to screen from list files
-- @param awesome.screen s Screen that is needed to set wallpaper
-- @param table list_files List of wallpaper files
local function set_wallpaper(s, list_files)
  if next(list_files) ~= nil then
    if wallpaper.current == nil then
      wallpaper.current = list_files[math.random(1, #list_files)]
    end
    wallpaper_lib.maximized(wallpaper.current, s, false)
  end
  collectgarbage('collect')
end

-- Automatically change wallpaper in seconds
-- @param awesome.screen s Screen that is needed to auto change wallpaper
local function auto_change_wallpaper(s)
  wallpaper.timer:connect_signal('start', function()
    set_wallpaper(s, wallpaper.files)
  end)
  if not wallpaper.timer.started then
    wallpaper.timer:connect_signal('timeout', function()
      wallpaper.current = nil
      wallpaper.timer:stop()
      wallpaper.timer:start()
    end)
  end
end

-- }

-- { Redshift
local redshift_state

-- Dim screen
local function redshift_dim()
  shell.run_command('redshift -o', true, function()
    redshift_state = 1
  end)
end

-- Undim screen
local function redshift_undim()
  shell.run_command('redshift -x', true, function()
    redshift_state = 0
  end)
end

-- Toggle redshift state
local function redshift_toggle()
  if redshift_state == 1 then
    redshift_undim()
  else
    redshift_dim()
  end
end

-- Initial screen to normal
local function redshift_init()
  redshift_state = 0
  redshift_undim()
end

-- }

-- { Switch only occupied workspace
-- @param number direction Number that greater than 0 is right, less than 0 is left
local function switch_occupied_tag(direction)
  local screen = awful.screen.focused()
  local tag_number = awful.tag.getidx(awful.tag.selected(screen))
  local tag
  local all_tags = awful.tag.gettags(screen)
  local direction = (direction > 0) and 1 or -1
  for i = 1, #all_tags do
    tag = all_tags[awful.util.cycle(#all_tags, tag_number + direction * i)]
    if #tag:clients() > 0 then
      break
    end
  end
  awful.tag.viewonly(tag)
end

-- }

-- { Get processes info
-- @param function callback Callback is run when
local function get_processes_info(callback)
  shell.run_command(
    'ps --sort -c,-s -eo fname,%cpu,%mem,user,pid,etime,tname | head -n ' .. number_of_processes,
    true,
    function(stdout)
      stats = string.gsub(stdout, 'COMMAND', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, '%%CPU', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, '%%MEM', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'USER', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'PID', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'TTY', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'ELAPSED', markup_text('%1', beautiful.popup_fg_htop_title))
      callback(stats)
    end,
    nil,
    true
  )
end

-- }

-- { Run application at specific workspace
-- @param string prg Program to run
-- @param string workspace Name of workspace
local function run_at_workspace(prg, workspace)
  if not prg or not workspace then
    return nil
  end

  local function find_workspace_index(workspace)
    for k, v in pairs(workspaces) do
      if v == workspace then
        return k
      end
    end
  end

  local workspace_index = find_workspace_index(workspace)
  local screen = awful.screen.focused()
  local tag = screen.tags[workspace_index]

  local function move_client(window)
    awful.client.movetotag(tag, window)
    client.disconnect_signal('manage', move_client)
  end

  client.connect_signal('manage', move_client)
  shell.run_command(prg, true)
  if tag then
    tag:view_only()
  end
end

-- }

return {
  auto_change_wallpaper = auto_change_wallpaper,
  linux_distribution = linux_distribution,
  redshift_toggle = redshift_toggle,
  redshift_init = redshift_init,
  switch_occupied_tag = switch_occupied_tag,
  get_processes_info = get_processes_info,
  run_at_workspace = run_at_workspace,
}
