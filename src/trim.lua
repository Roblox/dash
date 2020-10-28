--[[
	Remove any whitespace at the start and end of `string`.
]]
local function trim(input: string)
	return input:match("^%s*(.-)%s*$")
end

return trim