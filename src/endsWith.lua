--[[
	Checks if `input` ends with the string `suffix`.
	@example dash.endsWith("Fun Roblox Games", "Games") --> true
	@example dash.endsWith("Bad Roblox Memes", "Games") --> false
	@trait Chainable
]]
local function endsWith(input: string, suffix: string)
	return input:sub(-suffix:len()) == suffix
end

return endsWith