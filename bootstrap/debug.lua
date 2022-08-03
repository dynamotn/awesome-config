-- Notification library
local naughty = require('naughty')
-- Transform Lua value into a human-readable representation
local inspect = require('inspect.inspect')

-- Debug variable
-- @param vars Variable to debug
-- @param is_notification Show notification to display variable or not
_G.dbg = function(vars, is_notification)
  vars = vars or ''
  is_notification = is_notification or false
  local text = inspect(vars)
  if is_notification then
    naughty.notify({ text = text })
  else
    local file = io.open('.awesome_dbg', 'a')
    io.output(file)
    io.write(text .. '\n')
    io.close(file)
  end
end
