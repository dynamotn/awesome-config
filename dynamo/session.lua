-- Custom library
local shell = require('dynamo.shell')
local dstring = require('dynamo.string')

-- Quit session
local function quit()
  dynamo_prompt:show_confirm_prompt('Quit session', nil, function()
    awesome.emit_signal('exit', nil)
    awesome.quit()
  end)
end

-- Hibernate
local function hibernate()
  dynamo_prompt:show_confirm_prompt('Hibernate', nil, function()
    shell.run_command('sudo systemctl hibernate' .. or_operator('pm-hibernate'), true)
  end)
end

-- Reboot
local function reboot()
  dynamo_prompt:show_confirm_prompt('Reboot', nil, function()
    awesome.emit_signal('exit', nil)
    shell.run_command('sudo reboot', true)
  end)
end

-- Shutdown
local function shutdown()
  dynamo_prompt:show_confirm_prompt('Shutdown', nil, function()
    awesome.emit_signal('exit', nil)
    shell.run_command('sudo shutdown -P now', true)
  end)
end

-- Shutdown
local function schedule_shutdown()
  dynamo_prompt:show_confirm_prompt('Shutdown', 'Please enter time', function(input)
    awesome.emit_signal('exit', nil)
    shell.run_command('sudo shutdown -P ' .. dstring.trim(input), true)
  end)
end

return {
  quit = quit,
  hibernate = hibernate,
  reboot = reboot,
  shutdown = shutdown,
  schedule_shutdown = schedule_shutdown,
}
