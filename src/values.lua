local insert = table.insert

local function values(input)
	local result = {}
	for _, value in pairs(input) do
		insert(result, value)
	end
	return result
end
return values