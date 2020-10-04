--!strict
local function filter(input, fn)
	local result = {}
	for key, child in ipairs(input) do
		if fn(child, key) then
			table.insert(result, child)
		end
	end
	return result
end
return filter