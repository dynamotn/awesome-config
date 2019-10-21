-- Notification library
local naughty = require("naughty")
-- Custom library
local trim = require("dynamo.string").trim
local shell = require("dynamo.shell")

-- { Show properties of window
local function xprop()
  dynamo_prompt:set_prompt("Show properties of window")
  if not mousegrabber.isrunning() then
    mousegrabber.run(function(_mouse)
      for k, v in ipairs(_mouse.buttons) do
        if v then
          dynamo_prompt:set_prompt()
          local c = client.focus
          dbg({
              name = c.name,
              class = c.class,
              instance = c.instance,
              type = c.type,
              window = c.window,
              role = c.role,
              pid = c.pid,
            }, true)
          return false
        end
      end
      return true
    end, "target")
end
end
-- }

-- { Calculation
local function calculation()
  dynamo_prompt:show_confirm_prompt("Calculation", "Enter formula", function(expr)
    local expr = trim(expr)
    shell.run_command("echo '" .. expr .. "' | bc", true, function(result)
      naughty.notify({ text = expr .. " = " .. trim(result), timeout = 10, screen = mouse.screen })
    end)
  end)
end
-- }

return {
  xprop = xprop,
  calculation = calculation,
}
