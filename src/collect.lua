--[[
	Returns a new table by iterating over _input_ and calling _handler_ for each `(key, value)`.

	The _handler_ should return a `(newKey, newValue)` pair to insert into the result, or `nil` to skip.

	@returns A new table containing only the entries for which _handler_ returned a non-`nil` key.
	@see Dash.collectArray to build arrays while optionally skipping values.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

export type CollectHandler<Key, Value, NewKey, NewValue> = (key: Key, value: Value) -> (NewKey?, NewValue?)

local function collect<Key, Value, NewKey, NewValue>(
	input: Types.Map<Key, Value>,
	handler: CollectHandler<Key, Value, NewKey, NewValue>
): Types.Map<NewKey, NewValue>
	local result = {}
	for key, child in input do
		local outputKey, outputValue = handler(key, child)
		if outputKey ~= nil then
			result[outputKey] = outputValue
		end
	end
	return result
end

return collect
