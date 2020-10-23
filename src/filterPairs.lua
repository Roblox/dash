local function filterPairs(input, fn)
	local result = {}
	for key, child in pairs(input) do
		if fn(child, key) then
			result[key] = child
		end
	end
	return result
end
return filterPairs