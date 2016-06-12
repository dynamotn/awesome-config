-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
local html = require("html")

local function confirm_prompt(text_prompt, callback, text_confirm)
    local text_confirm = text_confirm or "Gõ 'Enter' để xác nhận? "
    dynamo.prompt(text_prompt)
    awful.prompt.run({ prompt = html(beautiful.fg_confirm, text_confirm) },
                     mypromptbox[mouse.screen].widget,
                     function (t)
                         dynamo.prompt()
                         callback(t)
                     end,
                     nil, nil, nil,
                     function (t)
                         dynamo.prompt()
                     end)
end
-- {{{ Lock function when using LightDM
dynamo.lock = function()
    confirm_prompt(" Khóa màn hình", function()
        awful.util.spawn("dm-tool switch-to-greeter")
    end)
end
-- }}}

-- {{{ Quit function when using GNOME session
dynamo.quit = function()
    confirm_prompt(" Thoát phiên", function ()
        awesome.emit_signal("exit", nil)
        if os.getenv("DESKTOP_SESSION") == "awesome-gnome" then
            awful.util.spawn("gnome-session-quit --no-prompt")
        else
            awesome.quit()
        end
    end)
end
-- }}}

-- {{{ Hibernate using systemd
dynamo.hibernate = function()
    confirm_prompt(" Ngủ đông", function ()
        awful.util.spawn("systemctl hibernate")
    end)
end
-- }}}

-- {{{ Reboot
dynamo.reboot = function()
    confirm_prompt(" Khởi động lại", function ()
        awesome.emit_signal("exit", nil)
        awful.util.spawn("reboot")
    end)
end
-- }}}

-- {{{ Shutdown
dynamo.shutdown = function()
    confirm_prompt(" Tắt máy", function ()
        awesome.emit_signal("exit", nil)
        awful.util.spawn("shutdown -P now")
    end)
end
-- }}}

-- {{{ Shutdown when at a time
dynamo.shutdown_schedule = function()
    confirm_prompt(" Tắt máy", function (t)
        awful.util.pread("shutdown -P " .. trim(t))
    end, "Nhập vào thời gian ")
end
-- }}}
