--[[
	Filter a table of values by calling the handler on each `(child, key)` pair, preseving keys.

	The handler should return `true` to preserve the value in the resulting table.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: support generic function definitions
export type FilterHandler = (any, any) -> boolean

local function filterPairs(input: Types.Table, handler: FilterHandler)
	assertEqual(typeof(input), "table", [[Attempted to call Dash.filterPairs with argument #1 of type {left:?} not {right:?}]])
	assertEqual(typeof(handler), "function", [[Attempted to call Dash.filterPairs with argument #2 of type {left:?} not {right:?}]])
	local result = {}
	for key, child in pairs(input) do
		if handler(child, key) then
			result[key] = child
		end
	end
	return result
end
return filterPairs