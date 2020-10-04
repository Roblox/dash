--!strict
local function mapPairs(input, fn)
	local result = {}
	for key, child in pairs(input) do
		result[key] = fn(child, key)
	end
	return result
end
return mapPairs