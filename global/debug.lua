-- Notification library
local naughty = require('naughty')
-- Transform Lua value into a human-readable representation
local inspect = require('global.inspect')

-- { Useful debug function
function dbg(vars, notify)
  local vars = vars or ''
  local notify = notify or false
  local text = inspect(vars)
  if notify then
    naughty.notify({ text = text, timeout = 10 })
  else
    local file = io.open('.awesome_dbg', 'a')
    io.output(file)
    io.write(text .. '\n')
    io.close(file)
  end
end
-- }
