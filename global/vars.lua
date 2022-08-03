-- Get Linux distribution name
local misc = require('dynamo.misc')
linux_distribution = misc.linux_distribution()
-- }

-- { Launcher, panel
-- Workspace
-- }

-- { Wallpaper auto change config
local filesystem = require('dynamo.filesystem')
local gears = require('gears')
wallpaper = {
  files = filesystem.scan_dir_by_mime(filesystem.xdg_user_dirs('PICTURES') .. '/Wallpaper', 'image'),
  timer = gears.timer({ timeout = 10 }),
}
-- }

-- { Popup config
number_of_processes = 25
-- }
