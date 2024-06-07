--[[
	Build a set from the entries of the _input_ Table, calling _handler_ on each entry and using
	the returned value as an element to add to the set.

	If _handler_ is not provided, values of `input` are used as elements.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local iterator = require(Dash.iterator)

type CollectHandler = (key: any, value: any) -> any

-- TODO Luau: Support generic functions
local function collectSet(input: Types.Table, handler: CollectHandler?)
	local result = {}
	for key, child in iterator(input) do
		local outputValue
		if handler == nil then
			outputValue = child
		else
			outputValue = handler(key, child)
		end
		if outputValue ~= nil then
			result[outputValue] = true
		end
	end
	return result
end
return collectSet
