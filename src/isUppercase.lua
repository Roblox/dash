local byte_A = string.byte("A")
local byte_Z = string.byte("Z")

local function isUppercase(input: string)
	local byte = string.byte(input)
	return byte >= byte_A and byte <= byte_Z
end
return isUppercase