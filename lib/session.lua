-- AwesomeWM standard library
local awful = require('awful')
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Custom library
local shell = require('lib.shell')
local str = require('lib.string')
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

local characters_entered = 0

local function reset_lock()
  characters_entered = 0
  for s in screen do
    s.warning_text:set_markup(str.markup_text('', beautiful.fg_warning))
    s.input_password_box:set_markup(str.markup_text('Enter your password', beautiful.bg_normal))
  end
end

local function fail_lock(msg)
  characters_entered = 0
  for s in screen do
    s.warning_text:set_markup(str.markup_text('Failed to authenticate: ' .. msg, beautiful.fg_warning))
    s.input_password_box:set_markup(str.markup_text('Enter your password', beautiful.bg_normal))
  end
end

local function grab_password()
  awful.prompt.run({
    textbox = wibox.widget.textbox(),
    hooks = {
      {
        {},
        'Escape',
        function(_)
          reset_lock()
          grab_password()
        end,
      },
    },
    keypressed_callback = function(_, key, _)
      if #key == 1 then
        characters_entered = characters_entered + 1
      elseif key == 'BackSpace' then
        if characters_entered > 0 then
          characters_entered = characters_entered - 1
        end
      end
      for s in screen do
        s.input_password_box:set_markup(str.markup_text(string.rep('', characters_entered), beautiful.fg_normal))
      end
    end,
    exe_callback = function(input)
      _G.input_password = input
      local a, err = pam.authenticate(_G.pam_handle)
      if not a then
        fail_lock(err)
        grab_password()
      else
        pam.endx(_G.pam_handle, pam.SUCCESS)
        reset_lock()
        unlock()
      end
    end,
  })
end

-- Lock session
local function lock()
  if _G.is_lock then
    return
  end
  _G.is_lock = true

  for s in screen do
    s.lockscreen.visible = true
  end

  local keygrabbing_instance = awful.keygrabber.current_instance
  if keygrabbing_instance then
    keygrabbing_instance:stop()
  end

  if client.focus then
    client.focus.minimized = true
  end

  for _, t in ipairs(mouse.screen.selected_tags) do
    _G.locked_workspace = t
    t.selected = false
  end

  reset_lock()
  _G.pam_handle, _ = pam.start('system-local-login', os.getenv('LOGNAME'), {
    function(messages)
      local responses = {}

      for i, message in ipairs(messages) do
        local msg_style, msg = message[1], message[2]
        if msg_style == pam.PROMPT_ECHO_OFF or msg_style == pam.PROMPT_ECHO_ON then
          responses[i] = { _G.input_password, 0 }
        elseif msg_style == pam.TEXT_INFO then
          awful.screen.focused().warning_text:set_markup(str.markup_text(msg, beautiful.fg_warning))
          responses[i] = { '', 0 }
        end
      end

      return responses
    end,
    nil,
  })
  grab_password()
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
    shell.run_command('sudo shutdown -P ' .. str.trim(input), true)
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
