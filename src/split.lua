--[[
	Splits `str` into parts based on a pattern delimiter and returns a table of the parts, followed
	by a table of the matched delimiters.
]]
local insert = table.insert

local function split(str: string, pattern: string)
	local parts = {}
	local delimiters = {}
	local from = 1
	if not pattern then
		for i = 1, #str do
			insert(parts, str:sub(i, i))
		end
		return parts
	end
	local delimiterStart, delimiterEnd = str:find(pattern, from)
	while delimiterStart do
		insert(delimiters, str:sub(delimiterStart, delimiterEnd))
		insert(parts, str:sub(from, delimiterStart - 1))
		from = delimiterEnd + 1
		delimiterStart, delimiterEnd = str:find(pattern, from)
	end
	insert(parts, str:sub(from))
	return parts, delimiters
end

return split