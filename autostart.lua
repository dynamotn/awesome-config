local run_one_pid = require("dynamo").shell.run_one_pid
-- { Composite manager
run_one_pid("picom", "--experimental-backends -b")
-- }

-- { Hide mouse when not use
run_one_pid("unclutter")
-- }

-- { Terminal with tmux
run_one_pid(terminal_tmux, nil, terminal)
-- }

-- { Password manager
-- run_one_pid("keepassxc")
-- }

-- { Browser
run_one_pid(browser)
-- }

-- { Clipboard manager
run_one_pid(clipboard)
-- }

-- { Network manager
run_one_pid("nm-applet")
-- }

-- { IM framework
run_one_pid("ibus-daemon", "-drx")
-- }

-- { Redshift
require("dynamo.misc").redshift_init()
-- }

-- { MPD
run_one_pid("mpd")
-- }

-- { Ferdi
run_one_pid("ferdi")
-- }

-- { Mail
-- run_one_pid("thunderbird")
-- }
