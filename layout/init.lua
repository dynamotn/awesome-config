local setmetatable = setmetatable

return setmetatable(
        { _NAME = "layout" },
        { __index = function(table, key)
                local module = rawget(table, key)
                return module or require(table._NAME .. '.' .. key)
        end }
)
