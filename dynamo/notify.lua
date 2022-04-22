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
    end, nil, true)
  end)
end
-- }

-- { Toggle popup
local popup
local is_show_popup = false

-- Hide popup
local function hide_popup()
  is_show_popup = false
  if popup ~= nil then
    naughty.destroy(popup)
    popup = nil
  end
end

-- Show notify with naughty library
-- @param string text Text is shown on notify
local function notify(text)
  -- Must check has current show before because it's async
  if is_show_popup then
    hide_popup()
    popup = naughty.notify({ text = text, timeout = 0, screen = mouse.screen })
  end
end

-- Show popup
-- @param any callback Text, string, table is shown or callback function to process text
-- Callback function must have first argument that is a function same with notify(text) function
local function show_popup(callback)
  is_show_popup = true
  if type(callback) == "function" then
    callback(notify)
  else
    notify(callback)
  end
end

-- Initial popup when hover mouse on widget
-- @param table widget Widget that need to show popup
-- @param function callback See param of show_popup function
local function init_popup(widget, callback)
  widget:connect_signal("mouse::enter", function() show_popup(callback) end)
  widget:connect_signal("mouse::leave", function() hide_popup() end)
end
-- }

return {
  xprop = xprop,
  calculation = calculation,
  init_popup = init_popup,
}
