-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Hide mouse if not use
run_once("unclutter")
-- }}}

-- {{{ Chat
run_once("franz")
-- }}}

-- {{{ Web Browser
run_once(browser)
-- }}}

-- {{{ Clipboard
run_once("clipit")
-- }}}

-- {{{ Uim
run_once("uim-systray")
-- }}}

-- {{{ Urxvt
run_once("urxvtd", "-o -q -f")
-- }}}

-- {{{ Mpd
run_once("mpd")
-- }}}

-- {{{ Composite manager
run_once("compton")
-- }}}

-- {{{ Note
run_once("zim")
-- }}}

-- {{{ Dev docs
run_once("zeal")
-- }}}
