local insert = table.insert

local function collectArray(input, fn)
	local result = {}
	for key, child in pairs(input) do
		local outputValue = fn(key, child)
		if outputValue ~= nil then
			insert(result, outputValue)
		end
	end
	return result
end
return collectArray