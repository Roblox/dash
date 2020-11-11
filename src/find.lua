--[[
	Returns an element in the _input_ Table that the handler returns `true` for, when passed the
	`(child, key)` entry.

	Returns nil if no entires satisfy the condition.

	If there are multiple entries matching the condition, one is returned arbitrarily.

	@see Dash.first for a function which returns the first element of an Array matching a condition.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: support generic function definitions
export type FindHandler = (any, any) -> boolean

local function find(input: Types.Map<any, any>, handler: FindHandler)
	assertEqual(typeof(input), "table", [[Attempted to call Dash.find with argument #1 of type {left:?} not {right:?}]])
	assertEqual(typeof(handler), "function", [[Attempted to call Dash.find with argument #2 of type {left:?} not {right:?}]])
	for key, child in pairs(input) do
		if handler(child, key) then
			return child
		end
	end
end
return find