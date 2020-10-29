--!strict
--[[
	Iterates through the elements of the _input_ array using the ordered keys 1..n.
	Calls the _handler_ for each entry.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

export type ForEachHandler<Value> = (Value, number) -> ()
-- TODO Luau: Support function generics
--local function forEach<Value>(input: Types.Array<Value>, handler: ForEachHandler<Value>)
local function forEach(input: any, handler: any)
	for key, value in ipairs(input) do
		handler(value, key)
	end
end
return forEach