local run_one_pid = require('lib.shell').run_one_pid
local run_one_class = require('lib.shell').run_one_class
-- Configuration
local apps = require('config.apps')

-- { Composite manager
run_one_pid(apps.composite_manager, '--experimental-backends -b')
-- }

-- { Hide mouse when not use
run_one_pid('unclutter')
-- }

-- { Terminal with tmux
run_one_class(apps.startup_terminal, nil, apps.terminal)
-- }

-- { Browser
run_one_class(apps.browser, nil, 'firefox')
-- }

-- { Clipboard manager
run_one_pid(apps.clipboard)
-- }

-- { IM framework
run_one_pid('ibus-daemon', '-drR')
-- }

-- { Redshift
require('lib.redshift').init()
-- }

-- { MPD from Mopidy
run_one_pid(apps.music_server)
-- }

-- { Firefox to chat
run_one_class(apps.chat_client, nil, 'dynamo_chat')
-- }

-- { Mail
run_one_class(apps.email_client, nil, 'thunderbird')
-- }

-- { Locker
run_one_pid(apps.locker_cmd)
-- }

-- { Wallpaper
run_one_class(apps.wallpaper, nil, 'dynamo_wallpaper')
-- }
