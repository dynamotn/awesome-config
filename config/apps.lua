local M = {
  terminal = 'kitty',
  editor = os.getenv('EDITOR') or 'vim',
  browser = 'firefox',
  clipboard = 'greenclip daemon',
  music_server = 'mopidy',
  music_player = 'ncmpcpp',
  music_controller = 'playerctl',
  sound_controller = 'pactl',
  email_client = 'thunderbird',
  launcher = 'rofi',
  composite_manager = 'picom',
  system_monitor = 'btop',
  gpu_monitor = 'nvtop',
  automation_tool = 'xdotool',
  locker_tool = 'xss-lock',
}

-- Run with launcher
M.application_launcher = M.launcher .. ' -show drun'
M.command_launcher = M.launcher .. ' -show run'
M.clipboard_launcher = function(window_id)
  return M.launcher
    .. " -modi 'clipboard:greenclip print' -show clipboard "
    .. '&& sleep 0.1 && '
    .. M.automation_tool
    .. ' windowactivate --sync '
    .. window_id
    .. ' && '
    .. M.automation_tool
    .. ' key --clearmodifiers Shift+Insert'
end
M.password_launcher = function(window_id)
  return os.getenv('SHELL') .. ' -c __bitrofi_show_items'
end
M.calculator_launcher = M.launcher
  .. ' -modi calc -show calc -no-show-match -no-sort -calc-command \'echo -n "{result}" | xsel -i -b\''

-- Terminal apps
M.editor_cmd = M.terminal .. ' ' .. M.editor
M.quake_cmd = M.terminal .. ' --class dynamo_kittuake'
M.music_player_cmd = M.terminal .. ' --class dynamo_music ' .. M.music_player
M.system_monitor_cmd = M.terminal .. ' --class dynamo_monitor ' .. M.system_monitor
M.gpu_monitor_cmd = M.terminal .. ' --class dynamo_gpu ' .. M.gpu_monitor
M.startup_terminal = M.terminal
  .. ' '
  .. os.getenv('SHELL')
  .. " -c 'tmux -q has-session && tmux attach-session -d || tmux new-session -nwtf -s$USER@$HOSTNAME'"
M.music_play_cmd = M.music_controller .. ' --all-players play'
M.music_pause_cmd = M.music_controller .. ' --all-players pause'
M.music_stop_cmd = M.music_controller .. ' --all-players stop'
M.music_next_cmd = M.music_controller .. ' --all-players next'
M.music_previous_cmd = M.music_controller .. ' --all-players previous'
M.volume_raise_cmd = M.sound_controller .. ' set-sink-volume @DEFAULT_SINK@ +1%'
M.volume_lower_cmd = M.sound_controller .. ' set-sink-volume @DEFAULT_SINK@ -1%'
M.volume_mute_cmd = M.sound_controller .. ' set-sink-mute @DEFAULT_SINK@ toggle'
M.locker_cmd = M.locker_tool .. ' awesome-client "awesome.emit_signal(\'lockscreen::start\')"'

-- GUI apps
M.chat_client = M.browser .. ' --no-remote --class dynamo_chat -P Chat'

return M
