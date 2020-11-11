--[[
	Iterates through the elements of the _input_ Table in no particular order.

	Returns a new Table where the input keys are mapped to the values returned from calling the
	_handler_ on each `(child, key)` pair.

	Values returned by _handler_ must be defined.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: Support generic functions
export type MapHandler = (any, any) -> any

local function mapPairs(input: Types.Array<any>, handler: MapHandler): Types.Array<any>
	assertEqual(typeof(input), "table", [[Attempted to call Dash.mapPairs with argument #1 of type {left:?} not {right:?}]])
	assertEqual(typeof(handler), "function", [[Attempted to call Dash.mapPairs with argument #2 of type {left:?} not {right:?}]])
	local result = {}
	for key, child in pairs(input) do
		local value = handler(child, key)
		assertEqual(value == nil, false, [[Returned nil from a Dash.mapPairs handler]])
		result[key] = value
	end
	return result
end
return mapPairs