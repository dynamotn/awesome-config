-- AwesomeWM standard library
local awful = require("awful")
-- Widget library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local markup_text = require("dynamo.string").markup_text
local label = require("dynamo.widget.label")
local gears = require("gears")

local function decorate_workspace(workspace)
  local fg_focus = beautiful.taglist_fg_focus or beautiful.fg_focus
  local bg_focus = beautiful.taglist_bg_focus or beautiful.bg_focus
  local fg_urgent = beautiful.taglist_fg_urgent or beautiful.fg_urgent
  local bg_urgent = beautiful.taglist_bg_urgent or beautiful.bg_urgent
  local bg_occupied = beautiful.taglist_bg_occupied
  local fg_occupied = beautiful.taglist_fg_occupied
  local bg_empty = beautiful.taglist_bg_empty
  local fg_empty = beautiful.taglist_fg_empty
  local font = beautiful.taglist_font or beautiful.font or ""
  local text = ""
  local sel = client.focus
  local bg_color = nil
  local fg_color = nil
  local state = nil
  local windows = workspace:clients()
  if #windows > 0 then
    if bg_occupied then bg_color = bg_occupied end
    if fg_occupied then fg_color = fg_occupied end
    state = "occupied"
  else
    if bg_empty then bg_color = bg_empty end
    if fg_empty then fg_color = fg_empty end
    state = "empty"
  end
  for i, window in pairs(windows) do
    if window.urgent then
      if bg_urgent then bg_color = bg_urgent end
      if fg_urgent then fg_color = fg_urgent end
      state = "urgent"
      break
    end
  end
  if workspace.selected then
    bg_color = bg_focus
    fg_color = fg_focus
    state = "focus"
  end
  text = markup_text(awful.util.escape(workspace.name), fg_color, font)

  return text, bg_color, state
end

local function update(w, buttons, _, data, workspaces)
  -- update the widgets, creating them if needed
  w:reset()
  for i, workspace in ipairs(workspaces) do
    local cache = data[workspace]
    local tb, bgb
    local text, bg, state = decorate_workspace(workspace)
    local interval = 0
    if state == "urgent" then
      interval = beautiful.taglist_blink_interval
    else
      interval = 0
    end

    if cache then
      tb = cache.tb
      bgb = cache.bgb
    else
      tb = label()
      bgb = wibox.container.background()
      bgb:setup {
        widget = wibox.layout.fixed.horizontal(),
        buttons = awful.widget.common.create_buttons(buttons, workspace),
        tb,
      }

      data[workspace] = {
        tb = tb,
        bgb = bgb,
      }
    end

    -- The text might be invalid, so use pcall
    if not pcall(tb.set_markup, tb, text) then
      tb:set_markup("<i>&lt;Invalid text&gt;</i>")
    end
    tb:set_color(bg, interval)
    w:add(bgb)
  end
end

local function create(args)
  args.update_function = update
  return awful.widget.taglist(args)
end

return setmetatable({}, { __call = function(_, ...) return create(...) end })
