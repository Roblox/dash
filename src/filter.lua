--[[
	Filter the _input_ Table by calling the handler on each `(child, index)` tuple.

	For an Array input, the order of elements is prevered in the output.

	The handler should return truthy to preserve the value in the resulting Table.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: support generic function definitions
export type FilterHandler = (any, any) -> boolean

local function filter(input: Types.Table, handler: FilterHandler): Types.Array<any>
	local result = {}
	for index, child in input do
		if handler(child, index) then
			table.insert(result, child)
		end
	end
	return result
end
return filter
