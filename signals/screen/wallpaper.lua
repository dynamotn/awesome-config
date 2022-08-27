-- AwesomeWM standard library
local gears = require('gears')
-- Custom library
local filesystem = require('dynamo.filesystem')
local lgi = require('lgi')

-- Setup wallpaper
screen.connect_signal('request::wallpaper', function(s)
  local all_wallpapers = filesystem.scan_dir_by_mime(filesystem.xdg_user_dirs('PICTURES') .. '/Wallpaper', 'image')
  local current_wallpaper

  local timer = gears.timer.start_new(5, function()
    if next(all_wallpapers) ~= nil then
      if current_wallpaper == nil then
        current_wallpaper = all_wallpapers[math.random(1, #all_wallpapers)]
      end
      gears.wallpaper.maximized(current_wallpaper, s, false)
    end
    collectgarbage('collect')
  end)

  timer:connect_signal('timeout', function()
    timer:start()
  end)
end)
