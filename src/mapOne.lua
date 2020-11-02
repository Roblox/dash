--!strict
local function mapOne(input, fn)
	for key, child in pairs(input) do
		local output = fn(child, key)
		if output ~= nil then
			return output
		end
	end
end
return mapOne