--!strict
--[[
	Iterates through the elements of the _input_ map in no guaranteed order.
	Calls the _handler_ for each key-value pair.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

export type ForEachPairsHandler<Key, Value> = (Value, Key) -> ()
-- TODO Luau: Support function generics
--local function forEachPairs<Key, Value>(input: Types.Map<Key, Value>, handler: ForEachPairsHandler<Key, Value>)
local function forEachPairs(input: any, handler: any)
	for key, value in pairs(input) do
		handler(value, key)
	end
end
return forEachPairs