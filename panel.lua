-- AwesomeWM standard library
local awful = require("awful")
-- Widget library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Custom library
local powerline_section = require("dynamo.bar").powerline_section
local markup_text = require("dynamo.string").markup_text
local run_command = require("dynamo.shell").run_command
local array_values = require("dynamo.array").array_values
local vicious = require("vicious")
vicious.contrib = require("vicious.contrib")

-- { Left panel
local panel_index = 0

-- Menu button
dynamo_launcher = wibox.container.background(launcher, beautiful.prompt_bg_normal)

-- Powerline prompt
panel_index = panel_index + 1
dynamo_prompt = powerline_section(
  panel_index,
  dynamo_launcher,
  beautiful.prompt_bg_normal,
  "opaque"
)
vicious.register(
  dynamo_prompt,
  vicious.widgets.os,
  markup_text("$3@$4", beautiful.prompt_fg_normal)
)
-- }

-- { Right panel
local panel_index = -1

-- Layout button
dynamo_layout = function(screen)
  local panel_index = -1
  return powerline_section(panel_index, awful.widget.layoutbox(screen), beautiful.layout_bg_normal)
end

-- Clock
panel_index = panel_index - 1
dynamo_clock = powerline_section(panel_index)
vicious.register(
  dynamo_clock,
  vicious.widgets.date,
  markup_text("%I:%M:%S %p", beautiful.clock_fg_hour) .. markup_text(" %a %d %b", beautiful.clock_fg_date),
  1
)

-- Network
panel_index = panel_index - 1
dynamo_network = powerline_section(panel_index)
vicious.register(
  dynamo_network,
  vicious.contrib.net,
  markup_text("↓ ${total down_kb}", beautiful.network_fg_down) .. markup_text(" ↑ ${total up_kb}", beautiful.network_fg_up),
  1
)

-- Power
run_command("ls /sys/class/power_supply/BAT*", false, function(stdout)
  if not stdout then
    return
  end
  panel_index = panel_index - 1
  dynamo_power = powerline_section(panel_index)
  vicious.register(
    dynamo_power,
    vicious.widgets.bat,
    function(_, args)
      local text
      if args[1] == "⌁" then
        dynamo_power:set_widget(beautiful.power_icon_ac)
        text = "AC"
      elseif args[2] <= 5 then
        dynamo_power:set_widget(beautiful.power_icon_very_low)
      elseif args[2] <= 15 then
        dynamo_power:set_widget(beautiful.power_icon_low)
      else
        dynamo_power:set_widget(beautiful.power_icon_normal)
        if args[1] == '↯' then
          text = "Full"
        end
      end
      if not text then
        text = args[2] .. "%"
      end
      return text
    end,
    1,
    stdout -- FIXME: Assume that each laptop has only one battery
  )
end)

-- Memory
panel_index = panel_index - 1
dynamo_memory = powerline_section(panel_index, beautiful.memory_icon)
vicious.register(
  dynamo_memory,
  vicious.widgets.mem,
  "$2MB",
  1
)

-- TODO: Add NVidia GPU

-- CPU
panel_index = panel_index - 1
dynamo_cpu = powerline_section(panel_index, beautiful.cpu_icon)
vicious.register(
  dynamo_cpu,
  vicious.widgets.cpu,
  markup_text("$1%", beautiful.cpu_fg),
  1
)

-- Volume
panel_index = panel_index - 1
dynamo_volume = powerline_section(panel_index, nil, nil, beautiful.bg_normal)
vicious.register(
  dynamo_volume,
  vicious.widgets.volume,
  function(_, args)
    if args[2] == "♩" then
      dynamo_volume:set_widget(beautiful.volume_icon_mute)
    elseif args[1] == 0 then
      dynamo_volume:set_widget(beautiful.volume_icon_no)
    elseif args[1] <= 50 then
      dynamo_volume:set_widget(beautiful.volume_icon_low)
    else
      dynamo_volume:set_widget(beautiful.volume_icon_normal)
    end
    return args[1]
  end,
  1,
  "Master"
)

-- TODO: Add MPD mini player

-- Keyboard map indicator and switcher
panel_index = panel_index - 1
dynamo_keyboard = powerline_section(panel_index, awful.widget.keyboardlayout(), beautiful.bg_systray, "opaque")
-- }
