--!strict
local function mapOne(input, fn)
	for key, child in pairs(input) do
		local output
		if fn then
			output = fn(child, key)
		else
			output = child
		end
		if output ~= nil then
			return output
		end
	end
end
return mapOne