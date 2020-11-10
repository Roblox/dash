--[[
	Iterates through the elements of the _input_ Array using the ordered keys 1..n.
	Calls the _handler_ for each entry and constructs a new ordered Array from the returned values.

	Values returned by _handler_ must be defined.

	@see Dash.collectArray if you want to return nil values.
	@see Dash.mapPairs if you want to iterate through a Map.
]]

local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: Support generic functions
export type MapHandler = (any, number) -> any

-- TYPED: export type MapHandler<Input, Output> = (Value, number) -> Output
-- TYPED: local function map<Input, Output>(input: Types.Array<Input>, fn: MapFn<Input, Output>)<Output>

local function map(input: Types.Array<any>, handler: MapHandler): Types.Array<any>
	assertEqual(typeof(input), "table", [[Attempted to call Dash.map with argument #1 of type {left:?} not {right:?}]])
	assertEqual(typeof(handler), "function", [[Attempted to call Dash.map with argument #2 of type {left:?} not {right:?}]])
	local result = {}
	for key, child in ipairs(input) do
		local value = handler(child, key)
		assertEqual(value == nil, false, [[Returned nil from a Dash.map handler]])
		result[key] = value
	end
	return result
end
return map