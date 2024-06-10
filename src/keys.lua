--[[
	Returns an Array of the keys in the _input_ Table.

	If the input is an Array, ordering is preserved.

	If the input is a Map, elements are returned in an arbitrary order.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

local insert = table.insert

-- TODO Luau: Support generic functions
local function keys(input: Types.Table): Types.Array<any>
	local result = {}
	for key, _ in input do
		insert(result, key)
	end
	return result
end
return keys
