--[[
	Iterates through the elements of the _input_ Table in no particular order.

	Calls the _handler_ for each entry and returns `true` if the handler returns truthy for any
	element which it is called with.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: Support generic functions
export type SomeHandler = (any, any) -> boolean

local function some(input: Types.Map<any, any>, handler: SomeHandler): boolean
	for key, child in input do
		if handler(child, key) then
			return true
		end
	end
	return false
end
return some
