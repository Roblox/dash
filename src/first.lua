--[[
	Returns the first element in the _input_ Array that the handler returns `true` for, when
	passed the `(child, index)` entry.

	Returns nil if no entires satisfy the condition.

	If handler is not defined, the function simply returns the first element of the Array.

	@see Dash.find for a function which returns an element of a Map matching a condition.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)

-- TODO Luau: support generic function definitions
export type FindHandler = (any, any) -> boolean

local function first(input: Types.Array<any>, handler: FindHandler?)
	assertEqual(typeof(input), "table", [[Attempted to call Dash.first with argument #1 of type {left:?} not {right:?}]])
	for index, child in ipairs(input) do
		if not handler then
			return child
		end
		if handler(child, index) then
			return child
		end
	end
end
return first