awesome.connect_signal('startup', function()
  -- Autostart application
  require('signals.global.autostart')

  os.execute('xset s ' .. require('config.common').screen_saver_timeout)
end)
