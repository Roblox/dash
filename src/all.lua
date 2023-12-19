local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local iterator = require(Dash.iterator)

type AllHandler = (any, any) -> boolean

local function all(input: Types.Table, handler: AllHandler?): boolean
	assertEqual(typeof(input), "table", [[Attempted to call Dash.all with argument #1 of type {left:?} not {right:?}]])
	for key, value in iterator(input) do
		if handler then
			if not handler(value, key) then
				return false
			end
		else
			if not value then
				return false
			end
		end
	end
	return true
end

return all
