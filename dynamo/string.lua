-- { Trim string
-- @param string s String is needed to trim space
-- @return string Trimmed string
local function trim(s)
  return s:gsub('^%s+', ''):gsub('%s+$', ''):gsub('[\n\r]+$', '')
end
-- }

-- { Extract string line by line
-- @param string s String is needed to extract
-- @return table All lines of string
local function extract_lines(s)
  local result = {}
  trim(s):gsub('([^\n\r]+)', function(line)
    table.insert(result, line)
  end)
  return result
end
-- }

return {
  trim = trim,
  extract_lines = extract_lines,
}

