--[[
	Returns the last element in the _input_ array that the handler returns `true` for, when
	passed the `(child, index)` entry.

	Returns nil if no entires satisfy the condition.

	If handler is not defined, the function simply returns the last element of the array.
]]

-- TODO Luau: support generic function definitions
export type FindHandler = (any, any) -> boolean

local function last(input: { any }, handler: FindHandler?)
	for index = #input, 1, -1 do
		local child = input[index]
		if not handler then
			return child
		end
		if handler and handler(child, index) then
			return child
		end
	end
	return nil
end

return last
