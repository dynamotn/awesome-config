-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Notification library
local naughty = require("naughty")
-- }}}

-- {{{ Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- }}}

-- {{{ Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Debug
local function print_tab(depth)
    local result = ""
    if depth > 0 then
        for i = 1, depth do
            result = result .. '  '
        end
    end
    return result
end

local function array_to_text(arr, depth)
    local result = print_tab(depth)
    if type(arr) == "table" then
        result = result .. "array {\n"
        for i = 1, #arr do
            if i == #arr then
                result = result .. tostring(array_to_text(arr[i], depth + 1)) .. "\n" .. print_tab(depth) .. "}"
            else
                result = result .. tostring(array_to_text(arr[i], depth + 1)) .. "\n"
            end
        end
    else
        result = result .. tostring(arr) 
    end
    return result
end

function dbg(vars, args)
    local vars = vars or ""
    local args = args or {}
    local notify = args.notify or false
    local text = array_to_text(vars, 0)
    if notify then
        naughty.notify({ text = text, timeout = 5 })
    else
        local file = io.open(".awesome_dbg", "a")
        io.output(file)
        io.write(text .. '\n')
        io.close(file)
    end
end
-- }}}
