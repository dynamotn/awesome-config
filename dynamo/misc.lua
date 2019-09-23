-- Wallpaper library
local wallpaper_lib = require("gears.wallpaper")

-- { Set wallpaper
-- Set random wallpaper to screen from list files
-- @param awesome.screen s Screen that is needed to set wallpaper
-- @param table list_files List of wallpaper files
local function set_wallpaper(s, list_files)
  if next(list_files) ~= nil then
    wallpaper_lib.maximized(list_files[math.random(1, #list_files)], s, true)
  end
  collectgarbage("collect")
end

-- Automatically change wallpaper in seconds
-- @param awesome.screen s Screen that is needed to auto change wallpaper
local function auto_change_wallpaper(s)
  wallpaper.timer:connect_signal("timeout", function()
    wallpaper.timer:stop()
    set_wallpaper(s, wallpaper.files)
    wallpaper.timer:start()
  end)
  set_wallpaper(s, wallpaper.files)
  wallpaper.timer:start()
end
-- }

return {
  auto_change_wallpaper = auto_change_wallpaper,
}
