-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
local html = require("html")
-- {{{ Lock function when using LightDM
dynamo.lock = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Khóa màn hình (gõ 'y' hoặc 'c' để xác nhận)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
            awful.util.spawn("dm-tool switch-to-greeter")
        end
    end,
    function (t, p, n)
        return awful.completion.generic(t, p, n, { 'c', 'k' })
    end)
end
-- }}}

-- {{{ Quit function when using GNOME session
dynamo.quit = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Thoát phiên (gõ 'y' hoặc 'c' để xác nhận)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
            awesome.emit_signal("exit", nil)
            if os.getenv("DESKTOP_SESSION") == "awesome-gnome" then
                awful.util.spawn("gnome-session-quit --logout")
            else
                awesome.quit()
            end
        end
    end,
    function (t, p, n)
        return awful.completion.generic(t, p, n, { 'c', 'k' })
    end)
end
-- }}}

-- {{{ Hibernate using systemd
dynamo.hibernate = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Ngủ đông (gõ 'y' hoặc 'c' để xác nhận)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
	    awful.util.spawn("systemctl hibernate")
	end
    end,
    function (t, p, n)
        return awful.completion.generic(t, p, n, { 'c', 'k' })
    end)
end
-- }}}

-- {{{ Reboot
dynamo.reboot = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Khởi động lại (gõ 'y' hoặc 'c' để xác nhận)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
            awesome.emit_signal("exit", nil)
	    awful.util.spawn("reboot")
	end
    end,
    function (t, p, n)
        return awful.completion.generic(t, p, n, { 'c', 'k' })
    end)
end
-- }}}

-- {{{ Shutdown
dynamo.shutdown = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Tắt máy (gõ 'y' hoặc 'c' để xác nhận)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
            awesome.emit_signal("exit", nil)
	    awful.util.spawn("shutdown -P now")
	end
    end,
    function (t, p, n)
        return awful.completion.generic(t, p, n, { 'c', 'k' })
    end)
end
-- }}}

-- {{{ Shutdown when at a time
dynamo.shutdown_schedule = function()
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, "Tắt máy (nhập vào thời gian)? ") },
    mypromptbox[mouse.screen].widget,
    function (t)
	if string.lower(t) == 'y' or string.lower(t) == 'c' then
	    awful.util.spawn("shutdown -P " .. trim(t))
	end
    end)
end
-- }}}
