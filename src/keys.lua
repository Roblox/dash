local insert = table.insert

local function keys(input)
	local result = {}
	for key, _ in pairs(input) do
		insert(result, key)
	end
	return result
end
return keys