--[[
	Iterates through the elements of the _input_ Table.

	If the table is an array, it iterates in order 1..n.

	If the table is a Map, the keys are visited in an arbitrary order.

	Calls the _handler_ for each entry.
]]
local Dash = script.Parent
local iterator = require(Dash.iterator)

export type ForEachHandler<Value> = (Value, number) -> ()

local function forEach<Value>(input: { Value }, handler: ForEachHandler<Value>)
	for key, value in iterator(input) do
		handler(value, key)
	end
end
return forEach
