--[[
	Filter an Array of values by calling the handler on each `(child, index)` tuple, preserving
	array indicies.

	The handler should return truthy to preserve the value in the resulting array.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: support generic function definitions
export type FilterHandler = (any, any) -> boolean

local function filter(input: Types.Array<any>, handler: FilterHandler)
	assertEqual(typeof(input), "table", [[Attempted to call Dash.filter with argument #1 of type {left:?} not {right:?}]])
	assertEqual(typeof(handler), "function", [[Attempted to call Dash.filter with argument #2 of type {left:?} not {right:?}]])
	local result = {}
	for index, child in ipairs(input) do
		if handler(child, index) then
			table.insert(result, child)
		end
	end
	return result
end
return filter