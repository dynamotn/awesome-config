-- Notification library
local naughty = require("naughty")
-- Transform Lua value into a human-readable representation
local inspect = require("global.inspect")

-- { Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err)
      })
    in_error = false
  end)
end
-- }

-- { Useful debug function
function dbg(vars, notify)
  local vars = vars or ""
  local notify = notify or false
  local text = inspect(vars)
  if notify then
    naughty.notify({ text = text, timeout = 10 })
  else
    local file = io.open(".awesome_dbg", "a")
    io.output(file)
    io.write(text .. '\n')
    io.close(file)
  end
end
-- }
