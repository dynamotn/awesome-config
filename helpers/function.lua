-- vim:filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fdm=marker:foldmarker={{{,}}}
-- {{{ Scan directory, and optionally filter outputs
function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end
-- }}}

-- {{{ Run application only one pid
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        if is_fish_shell then
            awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "'; or " .. prg, screen)
        else
            awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")", screen)
        end
    else
        if is_fish_shell then
            awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."'; or " .. prg .. " " .. arg_string, screen)
        else
            awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")", screen)
        end
    end
end
-- }}}

-- {{{ Trim string
function trim(string)
    s = string.gsub(string, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end
-- }}}

-- {{{ Check file exist and readable
function file_exists(file)
    local f = io.open(file)
    if f then
        local s = f:read()
        f:close()
        f = s
    end
    return f ~= nil
end
-- }}}

-- {{{ Require other file lua if exist
function require_exist(lib)
    if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
        file_exists(awful.util.getdir("config") .. '/' .. lib) then
        require(lib)
    end
end
-- }}}
