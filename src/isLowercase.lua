local byte_A = string.byte("A")
local byte_z = string.byte("z")

local function isLowercaseLetter(input: string)
	local byte = string.byte(input)
	return byte >= byte_A and byte <= byte_z
end
return isLowercaseLetter