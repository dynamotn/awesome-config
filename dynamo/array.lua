-- Get value of array with cyclic index
-- @param table array
-- @param number index Index of array
local function array_values(array, cyclic_index)
  if type(array) ~= "table" then
    return
  end

  if cyclic_index % #array == 0 then
    return array[#array]
  else
    return array[cyclic_index % #array]
  end
end

return {
  array_values = array_values,
}
