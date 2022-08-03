-- Get Linux distribution name
local misc = require('dynamo.misc')
linux_distribution = misc.linux_distribution()
-- }

-- { Launcher, panel
-- Workspace
term_workspace = 'TERM'
web_workspace = 'WEB'
mail_workspace = 'MAIL'
music_workspace = 'M&V'
chat_workspace = 'CHAT'
doc_workspace = 'DOC'
game_workspace = 'GAME'
sys_workspace = 'SYS'
other_workspace = 'MORE'
workspaces = {
  term_workspace,
  web_workspace,
  mail_workspace,
  music_workspace,
  chat_workspace,
  doc_workspace,
  game_workspace,
  sys_workspace,
  other_workspace,
}
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
