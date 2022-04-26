local run_one_pid = require("dynamo").shell.run_one_pid
local misc = require("dynamo.misc")
linux_distribution = misc.linux_distribution()

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
run_one_pid(browser, nil, linux_distribution == "gentoo" and "/usr/lib64/firefox/firefox" or "/usr/lib/firefox/firefox")
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

-- { MPD from Mopidy
run_one_pid("mopidy")
-- }

-- { Ferdi
run_one_pid("ferdi")
-- }

-- { Mail
run_one_pid("thunderbird")
-- }
