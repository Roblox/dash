--[[
	Returns an array of the keys in the _input_ Table.

	If the input is an array, ordering is preserved.

	If the input is a Map, elements are returned in an arbitrary order.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local iterator = require(Dash.iterator)

local insert = table.insert

-- TODO Luau: Support generic functions
local function keys(input: Types.Table): { any }
	local result = {}
	for key, _ in iterator(input) do
		insert(result, key)
	end
	return result
end
return keys
