--[[
	Returns an Array of the keys in the _input_ Table.

	Ordering is not guaranteed.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

local insert = table.insert

-- TODO Luau: Support generic functions
local function keys(input: Types.Table): Types.Array<any>
	assertEqual(typeof(input), "table", [[Attempted to call Dash.keys with argument #1 of type {left:?} not {right:?}]])
	local result = {}
	for key, _ in pairs(input) do
		insert(result, key)
	end
	return result
end
return keys