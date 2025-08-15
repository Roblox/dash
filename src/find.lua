export type FindHandler<Key, Value> = (Value, Key) -> boolean

--[=[
	Returns the first element in the _input_ table that satisfies the _handler_ predicate.

	For an array input, the first matching element in order 1..n is returned.
	For a Map input, an arbitrary matching element is returned.

	@param input The table to search.
	@param handler Function called as `(value, key)` for each entry; return `true` to select the value.
	@return The first matching value, or `nil` if no entries satisfy the condition.
]=]
local function find<Key, Value>(input: { [Key]: Value }, handler: FindHandler<Key, Value>): Value?
	for key, child in input do
		if handler(child, key) then
			return child
		end
	end
	return nil
end

return find
