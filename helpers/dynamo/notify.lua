-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Notification library
local naughty = require("naughty")
-- Lua to HTML library
local html = require("html")

-- {{{ Calculation
dynamo.calculate = function ()
    awful.prompt.run({ prompt = html(beautiful.fg_command ,"Máy tính: ") },
    mypromptbox[mouse.screen].widget,
    function (expr)
        local result = awful.util.eval("return (" .. trim(expr) .. ")")
        naughty.notify({ text = html(beautiful.fg_focus, expr .. " = " .. result), timeout = 10, screen = mouse.screen })
    end,
    nil,
    awful.util.getdir("cache") .. "/history_calc")
end
-- }}}

dynamo.quote = function ()
    local result = awful.util.pread("fortune")
    naughty.notify({ text = result, timeout = 10, screen = mouse.screen })
end
