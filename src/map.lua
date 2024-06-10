--[[
	Iterates through the elements of the _input_ Table.

	For an Array input, the elements are visted in order 1..n.

	For a Map input, the elements are visited in an arbitrary order.

	Calls the _handler_ for each entry and constructs a new Table using the same keys but replacing
	the values with new ones returned from the handler.

	Values returned by _handler_ must be defined.

	@see Dash.collectArray if you want to return nil values.
]]

local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: Support generic functions
export type MapHandler = (any, number) -> any

-- TYPED: export type MapHandler<Input, Output> = (Value, number) -> Output
-- TYPED: local function map<Input, Output>(input: Types.Array<Input>, fn: MapFn<Input, Output>)<Output>

local function map(input: Types.Array<any>, handler: MapHandler): Types.Array<any>
	local result = {}
	for key, child in input do
		local value = handler(child, key)
		assertEqual(value == nil, false, [[Returned nil from a Dash.map handler]])
		result[key] = value
	end
	return result
end
return map
