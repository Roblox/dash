--[[
	Build a set from the entries of the `input` Table, calling `fn` on entry and using the returned
	value as an element to enter into the set.

	If fn is not provided, values in the `input` Table are used as elements.
]]
local insert = table.insert

local function collectSet(input, fn)
	local result = {}
	for key, child in pairs(input) do
		local outputValue
		if fn == nil then
			outputValue = child 
		else
			outputValue = fn(key, child)
		end
		if outputValue ~= nil then
			result[outputValue] = true
		end
	end
	return result
end
return collectSet