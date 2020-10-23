local insert = table.insert

local function collectSet(input, fn)
	local result = {}
	for key, child in pairs(input) do
		local outputValue = fn(key, child)
		if outputValue ~= nil then
			result[outputValue] = true
		end
	end
	return result
end
return collectSet