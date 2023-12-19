local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local reduce = require(Dash.reduce)

local function sum(input: Types.Array<number>): number
	assertEqual(typeof(input), "table", [[Attempted to call Dash.sum with argument #1 of type {left:?} not {right:?}]])
	return reduce(input, function(acc, num)
		return acc + num
	end, 0)
end

return sum
