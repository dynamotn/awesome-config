local shell = require('dynamo.shell')

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

return {
  get_distribution = get_distribution,
}
