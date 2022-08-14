-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local shell = require('dynamo.shell')
local dstring = require('dynamo.string')

-- Lock session
local function lock()
  _G.is_lock = not is_lock
  for s in screen do
    s.lockscreen.visible = not s.lockscreen.visible
  end
end

-- Quit session
local function quit()
  awful.screen.focused().panel.prompt:show_confirm_prompt('Quit session', nil, function()
    awesome.emit_signal('exit', nil)
    awesome.quit()
  end)
end

-- Hibernate
local function hibernate()
  awful.screen.focused().panel.prompt:show_confirm_prompt('Hibernate', nil, function()
    shell.run_command('systemctl hibernate', true)
  end)
end

-- Reboot
local function reboot()
  awful.screen.focused().panel.prompt:show_confirm_prompt('Reboot', nil, function()
    awesome.emit_signal('exit', nil)
    shell.run_command('systemctl reboot', true)
  end)
end

-- Shutdown
local function shutdown()
  awful.screen.focused().panel.prompt:show_confirm_prompt('Shutdown', nil, function()
    awesome.emit_signal('exit', nil)
    shell.run_command('systemctl poweroff', true)
  end)
end

-- Shutdown
local function schedule_shutdown()
  awful.screen.focused().panel.prompt:show_confirm_prompt('Shutdown', 'Please enter time', function(input)
    awesome.emit_signal('exit', nil)
    shell.run_command('sudo shutdown -P ' .. dstring.trim(input), true)
  end)
end

return {
  lock = lock,
  quit = quit,
  hibernate = hibernate,
  reboot = reboot,
  shutdown = shutdown,
  schedule_shutdown = schedule_shutdown,
}
