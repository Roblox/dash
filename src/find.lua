--[[
	Returns an element in the _input_ Table that the handler returns `true` for, when passed the
	`(child, key)` entry.

	Returns nil if no entires satisfy the condition.

	For an Array, this first matching element is returned.

	For a Map, an arbitrary matching element is returned if it exists.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local iterator = require(Dash.iterator)

-- TODO Luau: support generic function definitions
export type FindHandler = (any, any) -> boolean

local function find(input: Types.Table, handler: FindHandler)
	for key, child in iterator(input) do
		if handler(child, key) then
			return child
		end
	end
	return nil
end
return find
