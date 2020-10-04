--!strict
local function mapDefined(input, fn)
	local result = {}
	for key, child in ipairs(input) do
		local output = fn(child, key)
		if output ~= nil then
			table.insert(result, output)
		end
	end
	return result
end
return mapDefined