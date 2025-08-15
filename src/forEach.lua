export type ForEachHandler<Key, Value> = (Value, Key) -> ()

--[=[
	Iterates through the elements of the _input_ table and calls _handler_ for each entry.

	For an array input, the elements are visited in order 1..n.
	For a Map input, the keys are visited in an arbitrary order.

	@param input The table to iterate over.
	@param handler Function called as `(value, key)` for each entry.
]=]
local function forEach<Key, Value>(input: { [Key]: Value }, handler: ForEachHandler<Key, Value>)
	for key, value in input do
		handler(value, key)
	end
end

return forEach
