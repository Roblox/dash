--[[
	Returns an Array of the values in the _input_ Table.

	Ordering is not guaranteed.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

local insert = table.insert

-- TODO Luau: Support generic functions
local function values(input: Types.Table): Types.Table
	assertEqual(typeof(input), "table", [[Attempted to call Dash.values with argument #1 of type {left:?} not {right:?}]])
	local result = {}
	for _, value in pairs(input) do
		insert(result, value)
	end
	return result
end
return values