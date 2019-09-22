-- AwesomeWM standard library
local awful = require("awful")

-- { Run application only one pid
-- @param string prg Command to run
-- @param string arg_string Arguments of command
-- @param string pname Process command that need check if process is existed
local function run_one_pid(prg, arg_string, pname)
  if not prg then
    do return nil end
  end

  if not pname then
    pname = prg
  end

  if not arg_string or not not tostring(arg_string):find("^%s*$") then
    arg_string = ""
  else
    arg_string = " " .. arg_string
  end

  awful.spawn.easy_async_with_shell("pgrep -u $USER -x '" .. pname .. "'", function(stdout, stderr, reason, exit_code)
    if exit_code ~= 0 then
      awful.spawn(prg .. arg_string)
    end
  end)
end
-- }

return {
  run_one_pid = run_one_pid,
}
