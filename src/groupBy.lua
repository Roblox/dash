local insert = table.insert

local function groupBy(input, keyOrFn)
	local result = {}
	for key, child in pairs(input) do
		local groupKey
		if typeof(keyOrFn) == "string" then
			groupKey = child[keyOrFn]
		else
			groupKey = keyOrFn(child, key)
		end
		if groupKey ~= nil then
			if result[groupKey] then
				insert(result[groupKey], child)
			else
				result[groupKey] = {child}
			end
		end
	end
	return result
end
return groupBy