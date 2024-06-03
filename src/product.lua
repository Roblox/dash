local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local reduce = require(Dash.reduce)

local function product(input: Types.Array<number>): number
	assertEqual(
		typeof(input),
		"table",
		[[Attempted to call Dash.product with argument #1 of type {left:?} not {right:?}]]
	)
	return reduce(input, function(acc, num)
		return acc * num
	end, 1)
end

return product
