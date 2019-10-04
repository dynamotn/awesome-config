-- AwesomeWM standard library
local awful = require("awful")
-- Widget library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local taskbar = require("dynamo.widget.taskbar")

local function update(w, buttons, label, data, windows)
  -- update the widgets, creating them if needed
  w:reset()
  for i, window in ipairs(windows) do
    local cache = data[window]
    local bar

    if cache then
      bar = cache.bar
    else
      bar = taskbar(awful.widget.common.create_buttons(buttons, window))

      data[window] = {
        bar = bar
      }
    end

    local text, bg, bg_image, icon = label(window, bar.text)

    -- The text might be invalid, so use pcall
    if not bar.text:set_markup_silently(text) then
      bar.text:set_markup("<i>&lt;Invalid text&gt;</i>")
    end
    bar:set_bgimage(bg_image)
    bar.image:set_image(icon)

    w:add(bar)
  end
end

local function create(args)
  args.update_function = update
  return awful.widget.tasklist(args)
end

return setmetatable({}, { __call = function(_, ...) return create(...) end })
