-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Hide mouse if not use
run_once("unclutter")
-- }}}

-- {{{ Composite manager
run_once("compton")
-- }}}

-- {{{ Clipboard
run_once("clipit")
-- }}}

-- {{{ Fcitx
run_once("fcitx")
-- }}}

-- {{{ Network Manager Applet
run_once("nm-applet")
-- }}}

-- {{{ Urxvt
run_once("urxvtd", "-o -q -f")
-- }}}

-- {{{ Mpd
run_once("mpd")
-- }}}

-- {{{ KeepassXC
run_once("keepassxc")
-- }}}

-- {{{ Note
run_once("zim")
-- }}}
