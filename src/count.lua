local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local iterator = require(Dash.iterator)

type CountHandler = (any, any) -> boolean

local function count(input: Types.Table, handler: CountHandler?): number
	assertEqual(
		typeof(input),
		"table",
		[[Attempted to call Dash.count with argument #1 of type {left:?} not {right:?}]]
	)
	local count = 0
	for key, value in iterator(input) do
		if handler then
			if handler(value, key) then
				count += 1
			end
		else
			count += 1
		end
	end
	return count
end

return count
