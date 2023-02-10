-- Bling library
local bling = require('bling')
-- Custom library
local filesystem = require('lib.filesystem')

-- Setup wallpaper
local wallpaper_folder = filesystem.xdg_user_dirs('PICTURES') .. '/Wallpaper'
screen.connect_signal('request::wallpaper', function(s)
  bling.module.wallpaper.setup({
    screen = s,
    set_function = bling.module.wallpaper.setters.simple_schedule,
    wallpaper = {
      ['08:00:00'] = { wallpaper_folder .. '/day', wallpaper_folder .. '/all' },
      ['18:00:00'] = { wallpaper_folder .. '/night', wallpaper_folder .. '/all' },
    },
    schedule_set_function = bling.module.wallpaper.setters.random,
    position = 'maximized',
    ignore_aspect = true,
    recursive = false,
    change_timer = 60,
  })
end)
