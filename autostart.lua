local run_one_pid = require("dynamo").shell.run_one_pid
-- { Composite manager
run_one_pid("compton")
-- }

-- { Hide mouse when not use
run_one_pid("unclutter")
-- }

-- { Terminal with tmux
run_one_pid(terminal_tmux, nil, terminal)
-- }

-- { Password manager
run_one_pid("keepassxc")
-- }

-- { Browser
run_one_pid(browser)
-- }

-- { Clipboard manager
run_one_pid(clipboard)
-- }

-- { Redshift
require("dynamo.misc").redshift_init()
-- }

-- { MPD
run_one_pid("mpd")
-- }
