-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local misc = require('dynamo.misc')

-- AwesomwWM local configuration path
_G.local_rc_path = awful.util.get_configuration_dir()

-- Linux distribution name
_G.linux_distribution = misc.linux_distribution()
