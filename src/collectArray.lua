--[[
	Returns a new array by iterating over _input_ and calling _handler_ for each `(key, value)`.

	The _handler_ should return a new value to be pushed onto the end of the result array, or `nil` to skip.

	@returns A new array containing only the values returned by _handler_ that were not `nil`.
	@see Dash.map to transform values without filtering out `nil`.
]]

local insert = table.insert

type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?

local function collectArray<Key, Value, NewValue>(input: { [Key]: Value }, handler: CollectHandler<Key, Value, NewValue>): { NewValue }
	local result = {}
	for key, child in input do
		local outputValue = handler(key, child)
		if outputValue ~= nil then
			insert(result, outputValue)
		end
	end
	return result
end

return collectArray
