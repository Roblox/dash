--[[
	Returns the index of the first element in the _input_ array that the handler returns `true` for,
	when passed the `(child, key)` entry.

	Returns nil if no entires satisfy the condition.
]]

export type FindHandler<Value> = (Value, number) -> boolean

local function findIndex<Value>(input: { Value }, handler: FindHandler<Value>): number?
	for key = 1, #input do
		local child = input[key]
		if handler(child, key) then
			return key
		end
	end
	return nil
end
return findIndex
