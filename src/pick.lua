--[[
	Pick entries in the _input_ Table which should remain in the output by calling the handler on
	each `(child, index)` tuple.

	The handler should return truthy to preserve the value in the resulting Table.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local iterator = require(Dash.iterator)

-- TODO Luau: support generic function definitions
export type PickHandler = (any, any) -> boolean

local function pick(input: Types.Map<any, any>, handler: PickHandler): Types.Map<any, any>
	local result = {}
	for key, child in iterator(input) do
		if handler(child, key) then
			result[key] = child
		end
	end
	return result
end
return pick
