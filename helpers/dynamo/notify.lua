-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Notification library
local naughty = require("naughty")
-- Lua to HTML library
local html = require("html")
-- Vicious library
local vicious = require("vicious")

-- {{{ Calculation
dynamo.calculate = function ()
    prompt.text:set_markup(html(beautiful.fg_command ," Máy tính"))
    vicious.unregister(prompt.text)
    awful.prompt.run({ prompt = "" },
                     mypromptbox[mouse.screen].widget,
                     function (expr) -- Execute callback
                         vicious.register(prompt.text, vicious.widgets.os, html(beautiful.fg_command, " $3@$4"))
                         local result = awful.util.eval("return (" .. trim(expr) .. ")")
                         naughty.notify({ text = html(beautiful.fg_focus, expr .. " = " .. result), timeout = 10, screen = mouse.screen })
                     end,
                     nil, -- Complete callback
                     awful.util.getdir("cache") .. "/history_calc",
                     nil,
                     function (expr) -- Done callback
                         vicious.register(prompt.text, vicious.widgets.os, html(beautiful.fg_command, " $3@$4"))
                     end)
end
-- }}}

dynamo.quote = function ()
    local result = awful.util.pread("fortune")
    naughty.notify({ text = result, timeout = 10, screen = mouse.screen })
end
