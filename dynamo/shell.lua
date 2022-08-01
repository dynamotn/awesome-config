-- AwesomeWM standard library
local awful = require('awful')
-- Custom library
local dstring = require('dynamo.string')

-- { Run command
-- Run command and get result
-- @param string cmd Command
-- @param boolean is_async Flag is ran asynchronously
-- @param function succeed_callback Callback to process output of command when succeed
-- @param function failed_callback Callback to process output of command when failed
-- @param boolean with_shell Flag is ran with shell
-- @return  Result of callback function
local function run_command(cmd, is_async, succeed_callback, failed_callback, with_shell)
  local function post_run_command(stdout, stderr, _, exit_code)
    if exit_code ~= 0 and failed_callback then
      return failed_callback(stderr)
    elseif not exit_code ~= 0 and succeed_callback then
      return succeed_callback(stdout)
    else
      return nil
    end
  end

  if not cmd then
    return nil
  end
  if not is_async or is_async == false then
    local stream = io.popen(cmd)
    local stdout = stream:read('*all')
    local _, reason, exit_code = stream:close()
    return post_run_command(stdout, nil, reason, exit_code)
  else
    local spawn = with_shell and awful.spawn.easy_async_with_shell or awful.spawn.easy_async
    spawn(cmd, post_run_command)
  end
end

-- Run command synchronous and represent result by list of lines
-- @param string cmd Command
-- @param boolean is_async Flag is ran asynchronously
-- @param boolean with_shell Flag is ran with shell
-- @return table Result of command
local function run_command_multiple_lines(cmd, is_async, with_shell)
  return run_command(cmd, is_async, dstring.extract_lines, nil, with_shell)
end

-- Run command synchronous and represent by one line
-- @param string cmd Command
-- @param boolean is_async Flag is ran asynchronously
-- @param boolean with_shell Flag is ran with shell
-- @return string Result of command
local function run_command_one_line(cmd, is_async, with_shell)
  return run_command(cmd, is_async, dstring.trim, nil, with_shell)
end

-- }

-- { Run application only one pid
-- @param string prg Command to run
-- @param string arg_string Arguments of command
-- @param string pname Process command that need check if process is existed
-- @param boolean with_shell Flag is ran with shell
local function run_one_pid(prg, arg_string, pname, with_shell)
  if not prg then
    return nil
  end

  if not pname then
    pname = prg
  end

  if not arg_string or tostring(arg_string):find('^%s*$') then
    arg_string = ''
  else
    arg_string = ' ' .. arg_string
  end

  run_command("pgrep -u $USER -f '^" .. pname .. "*'", true, nil, function()
    run_command(prg .. arg_string, true, nil, nil, with_shell)
  end, true)
end

-- }

return {
  run_one_pid = run_one_pid,
  run_command = run_command,
  run_command_one_line = run_command_one_line,
  run_command_multiple_lines = run_command_multiple_lines,
}
