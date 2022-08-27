local run_one_pid = require('lib.shell').run_one_pid
-- Configuration
local apps = require('config.apps')

-- { Composite manager
run_one_pid(apps.composite_manager, '--experimental-backends -b')
-- }

-- { Hide mouse when not use
run_one_pid('unclutter')
-- }

-- { Terminal with tmux
run_one_pid(apps.startup_terminal, nil, apps.terminal)
-- }

-- { Browser
run_one_pid(
  apps.browser,
  nil,
  linux_distribution == 'gentoo' and '/usr/lib64/firefox/firefox' or '/usr/lib/firefox/firefox'
)
-- }

-- { Clipboard manager
run_one_pid(apps.clipboard)
-- }

-- { IM framework
run_one_pid('ibus-daemon', '-drx')
-- }

-- { Redshift
require('lib.redshift').init()
-- }

-- { MPD from Mopidy
run_one_pid(apps.music_server)
-- }

-- { Ferdi
run_one_pid(apps.message_client)
-- }

-- { Mail
run_one_pid(apps.email_client)
-- }

-- { Locker
run_one_pid(apps.locker_cmd)
-- }
