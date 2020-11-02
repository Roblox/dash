local byte_a = string.byte("a")
local byte_z = string.byte("z")

local function isLowercase(input: string)
	local byte = string.byte(input)
	return byte >= byte_a and byte <= byte_z
end
return isLowercase