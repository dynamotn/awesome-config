-- Custom shell library
local shell = require('lib.shell')

local state

-- Dim screen
local function dim()
  shell.run_command('redshift -o', true, function()
    state = 1
  end)
end

-- Undim screen
local function undim()
  shell.run_command('redshift -x', true, function()
    state = 0
  end)
end

-- Toggle redshift state
local function toggle()
  if state == 1 then
    undim()
  else
    dim()
  end
end

-- Initial screen to normal
local function init()
  state = 0
  undim()
end

return {
  toggle = toggle,
  init = init,
}
