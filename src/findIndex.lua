--[[
	Returns the index of the first element in the _input_ Array that the handler returns `true` for,
	when passed the `(child, key)` entry.

	Returns nil if no entires satisfy the condition.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: support generic function definitions
export type FindHandler = (any, any) -> boolean

local function findIndex(input: Types.Array<any>, handler: FindHandler)
	for key, child in ipairs(input) do
		if handler(child, key) then
			return key
		end
	end
	return nil
end
return findIndex
