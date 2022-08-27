require('signals.screen.wallpaper')
require('signals.screen.lockscreen')
require('signals.screen.workscreen')

-- Restart awesome when screens are removed or added
screen.connect_signal('added', awesome.restart)
screen.connect_signal('removed', awesome.restart)
