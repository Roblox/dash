--[[
	Returns an array of the values in the _input_ Map.

	If the input is an array, ordering is preserved.

	If the input is a Map, elements are returned in an arbitrary order.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

local insert = table.insert

local function values<Value>(input: Types.Map<unknown, Value>): { Value }
	local result = {}
	for _, value in input do
		insert(result, value)
	end
	return result
end
return values
