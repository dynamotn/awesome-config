-- Theme handling library
local beautiful = require('beautiful')
-- Custom library
local shell = require('lib.shell')
local markup_text = require('lib.string').markup_text

-- { Linux distribution detection
-- Check is specify distribution
-- @param string Distribution detection name
-- @return string Result of check command
local function is_linux_distribution(distribution_name)
  return shell.run_command_one_line("cat /etc/os-release | grep '" .. distribution_name .. "'") ~= ''
end

-- Get Linux distribution name
-- @return string Name of distribution
local function get_distribution()
  if is_linux_distribution('Ubuntu') then
    return 'ubuntu'
  elseif is_linux_distribution('Arch Linux') then
    return 'archlinux'
  elseif is_linux_distribution('Gentoo') then
    return 'gentoo'
  else
    return 'linux'
  end
end

-- }

-- { Get processes info
-- @param function callback Callback is run when
local function get_processes_info(callback)
  shell.run_command(
    'ps --sort -c,-s -eo fname,%cpu,%mem,user,pid,etime,tname | head -n '
      .. require('config.widgets').system.process_count,
    true,
    function(stdout)
      local stats
      stats = string.gsub(stdout, 'COMMAND', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, '%%CPU', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, '%%MEM', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'USER', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'PID', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'TTY', markup_text('%1', beautiful.popup_fg_htop_title))
      stats = string.gsub(stats, 'ELAPSED', markup_text('%1', beautiful.popup_fg_htop_title))
      callback(stats)
    end,
    nil,
    true
  )
end

-- }

return {
  get_distribution = get_distribution,
  get_processes_info = get_processes_info,
}
