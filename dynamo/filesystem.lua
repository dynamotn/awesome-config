-- Custom shell library
local shell = require("dynamo.shell")

-- { Advance function for file and directory
-- Scan directory, and optionally filter outputs
-- @param string kind Type to filter, include "mime"
-- @param string directory Absolute path of directory
-- @param string filter Filter follow by kind, see scan_dir_by_mime
-- @return table List of file name match with filter in directory
local function scan_dir(kind, directory, filter)
  if directory:sub(1, 1) ~= '/' then
    return {}
  end
  if kind ~= "mime" then
    return {}
  end
  local command = {
    mime = "find " .. directory .. " -type f -exec file -i {} + | awk -F': +' '{ if ($2 ~ /" .. filter .. "/) print $1 }'",
  }
  local i, result, files = 0, {}, shell.run_command(command[kind])
  for filename in files do
    table.insert(result, filename)
  end
  return result
end

-- Scan directory, and filter outputs by MIME type
-- @param string directory Absolute path of directory
-- @param string filter MIME type of file filter with escape character (eg: image, video, image\/png...)
-- @return table List of file name match with filter in directory
local function scan_dir_by_mime(directory, filter)
  return scan_dir("mime", directory, filter)
end
-- }

-- { XDG related
-- Get path of XDG user directory
-- @param string kind Type of XDG user directory
-- @return string Path of XDG user directory
local function xdg_user_dirs(kind)
  return shell.run_command_first_line("xdg-user-dir " .. kind)
end
-- }

return {
  scan_dir_by_mime = scan_dir_by_mime,
  xdg_user_dirs = xdg_user_dirs,
}
