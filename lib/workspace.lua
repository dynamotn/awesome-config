-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local shell = require('lib.shell')
local workspaces = require('config.workspaces').list

-- { Switch only occupied workspace
-- @param number direction Number that greater than 0 is right, less than 0 is left
local function switch_occupied_tag(direction)
  local screen = awful.screen.focused()
  local tag_number = awful.tag.getidx(awful.tag.selected(screen))
  local tag
  local all_tags = awful.tag.gettags(screen)
  direction = (direction > 0) and 1 or -1
  for i = 1, #all_tags do
    tag = all_tags[awful.util.cycle(#all_tags, tag_number + direction * i)]
    if #tag:clients() > 0 then
      break
    end
  end
  awful.tag.viewonly(tag)
end

-- }

-- { Run application at specific workspace
-- @param string prg Program to run
-- @param string workspace Name of workspace
local function run_at_workspace(prg, workspace)
  if not prg or not workspace then
    return nil
  end

  local function move_client(window)
    for s in screen do
      for _, tag in ipairs(awful.tag.gettags(s)) do
        if tag.name == workspace then
          awful.client.movetotag(tag, window)
          client.disconnect_signal('manage', move_client)
          return
        end
      end
    end
  end

  client.connect_signal('manage', move_client)
  shell.run_command(prg, true)
end

-- }

return {
  switch_occupied_tag = switch_occupied_tag,
  run_at_workspace = run_at_workspace,
}
