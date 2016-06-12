-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- Lua to HTML library
local html = require("html")
-- Vicious library
local vicious = require("vicious")

-- {{{ Non-empty tag browsing
dynamo.switch_tag = function (direction)
    local screen = mouse.screen or 1
    local tag_number = awful.tag.getidx(awful.tag.selected(screen))
    local tag = nil
    local alltag = awful.tag.gettags(screen)
    for i = 1, #alltag do
        tag = alltag[awful.util.cycle(#alltag, tag_number + direction * i)]
        if #tag:clients() > 0 then
            break
        end
    end
    awful.tag.viewonly(tag)
end
-- }}}

-- {{{ Re-show default prompt
dynamo.prompt = function(text)
    local text = text or nil
    if not text then
        vicious.register(prompt.text, vicious.widgets.os, html(beautiful.fg_command, " $3@$4"))
    else
        vicious.unregister(prompt.text)
        prompt.text:set_markup(html(beautiful.fg_command, text))
    end
end
-- }}}
