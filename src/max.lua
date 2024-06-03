local Dash = script.Parent
local Types = require(Dash.Types)
local assertEqual = require(Dash.assertEqual)
local reduce = require(Dash.reduce)

-- Return true if a > b
type MaxComparator = (any, any) -> boolean
type MaxHandler = (any, any) -> any

local function max(input: Types.Table, handler: MaxHandler?, comparator: MaxComparator?): number
	assertEqual(
		typeof(input),
		"table",
		[[Attempted to call Dash.product with argument #1 of type {left:?} not {right:?}]]
	)
	if handler and comparator then
		local acc = reduce(input, function(acc, value, key)
			local newValue = handler(value, key)
			if not acc then
				return { value = newValue, original = value }
			end
			return if comparator(newValue, acc.value) then { value = newValue, original = value } else acc
		end, nil)
		return acc.original
	elseif handler then
		local acc = reduce(input, function(acc, value, key)
			local newValue = handler(value, key)
			if not acc then
				return { value = newValue, original = value }
			end
			return if newValue > acc.value then { value = newValue, original = value } else acc
		end, nil)
		return acc.original
	elseif comparator then
		return reduce(input, function(acc, value)
			if not acc then
				return value
			end
			return if comparator(value, acc) then value else acc
		end, nil)
	end
	return reduce(input, function(acc, value)
		if not acc then
			return value
		end
		return if value > acc then value else acc
	end, nil)
end

return max
