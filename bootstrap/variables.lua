-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local distro = require('lib.distro')

-- AwesomwWM local configuration path
_G.local_rc_path = awful.util.get_configuration_dir()

-- Linux distribution name
_G.linux_distribution = distro.get_distribution()

-- Global lock screen state
_G.is_lock = false
_G.input_password = ''
_G.locked_workspace = nil
_G.pam_handle = nil
