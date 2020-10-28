local byte_A = string.byte("A")
local byte_z = string.byte("z")

local function isLowercaseLetter(input)
	if typeof(input) ~= "string" then
		return false
	end
	local byte = string.byte(input)
	return byte >= byte_A and byte <= byte_z
end
return isLowercaseLetter