--[[
	Checks if `input` starts with the string `start`.
	@example startsWith("Fun Roblox Games", "Fun") --> true
	@example startsWith("Chess", "Fun") --> false
]]
local function startsWith(input: string, prefix: string)
	return input:sub(1, prefix:len()) == prefix
end

return startsWith