-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local shell = require('dynamo.shell')
local dstring = require('dynamo.string')
local pam = require('pam')

-- Unlock session
local function unlock()
  _G.is_lock = false
  for s in screen do
    s.lockscreen.visible = false
  end

  if _G.locked_workspace then
    _G.locked_workspace.selected = true
    _G.locked_workspace = nil
  end

  local c = awful.client.restore()
  if c then
    c:emit_signal('request::activate')
    c:raise()
  end
end

-- Lock session
local function lock()
  if not _G.is_lock then
    _G.is_lock = true

    for s in screen do
      s.lockscreen.visible = true
    end

    local keygrabbing_instance = awful.keygrabber.current_instance
    if keygrabbing_instance then
      keygrabbing_instance:stop()
    end

    for _, t in ipairs(mouse.screen.selected_tags) do
      _G.locked_workspace = t
      t.selected = false
    end
  else
    awful.screen.focused().warning_text:set_markup('')

    awful.prompt.run({
      prompt = 'Password: ',
      textbox = awful.screen.focused().input_password_box.widget,
      highlighter = function(before, after)
        before = before:gsub('.', '*')
        after = after:gsub('.', '*')
        return before, after
      end,
      exe_callback = function(input)
        awesome.emit_signal('lock:enter_password', input)
      end,
    })
  end
end

awesome.connect_signal('lock:enter_password', function(input)
  local h, _ = pam.start('system-auth', os.getenv('LOGNAME'), {
    function(messages)
      local responses = {}

      for i, message in ipairs(messages) do
        local msg_style, msg = message[1], message[2]
        if msg_style == pam.PROMPT_ECHO_OFF or msg_style == pam.PROMPT_ECHO_ON then
          responses[i] = { input, 0 }
        else
          awful.screen.focused().warning_text:set_markup(msg)
          responses[i] = { '', 0 }
        end
      end

      return responses
    end,
    nil,
  })

  local a, err = pam.authenticate(h)
  if not a then
    awful.screen.focused().warning_text:set_markup('Error: ' .. err)
  else
    unlock()
    pam.endx(h, pam.SUCCESS)
  end
end)

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
