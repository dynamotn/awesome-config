-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Tmux
run_once(terminal_tmux, null, "tmux attach-session -d")
-- }}}

-- {{{ Chat
run_once("rambox")
-- }}}

-- {{{ Web Browser
run_once(browser, "", "chrome")
-- }}}
