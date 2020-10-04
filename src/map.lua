--!strict
local function map(input, fn)
	local result = {}
	for key, child in ipairs(input) do
		result[key] = fn(child, key)
	end
	return result
end
return map