local setmetatable = setmetatable

return setmetatable(
        { _NAME = "dynamo.widget" },
        { __index = function(table, key)
                local module = rawget(table, key)
                return module or require(table._NAME .. '.' .. key)
        end }
)
