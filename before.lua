-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Hide mouse if not use
run_once("unclutter")
-- }}}

-- {{{ Chat IRC
run_once("pidgin")
-- }}}

-- {{{ Web Browser
run_once("firefox")
-- }}}

-- {{{ Clipboard
run_once("clipit")
-- }}}

-- {{{ Uim
run_once("uim-systray")
-- }}}

-- {{{ Urxvt
run_once("urxvtd", "-o -q -f")
run_once("urxvtc")
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
