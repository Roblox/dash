local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local reduce = require(Dash.reduce)

type FrequenciesHandler = (any, any) -> any

local function frequencies(input: Types.Table, handler: FrequenciesHandler?): Types.Map<any, number>
	assertEqual(
		typeof(input),
		"table",
		[[Attempted to call Dash.frequencies with argument #1 of type {left:?} not {right:?}]]
	)
	return reduce(input, function(acc, value, key)
		local newKey = if handler then handler(value, key) else value
		if acc[newKey] == nil then
			acc[newKey] = 1
		else
			acc[newKey] += 1
		end
		return acc
	end, {})
end

return frequencies
