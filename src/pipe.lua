--[=[
	Creates a function that returns the result of passing a value through a pipeline of functions.
	Each function in the pipeline receives the result of the previous function.
	Functions are executed from left to right.

	@param funcs -- The functions to pipe
	@return -- A function that returns the result of passing a value through the pipeline
	@error "Expected a function" -- Thrown if any of the arguments is not a function

	@example
	```lua
	local function addOne(n)
		return n + 1
	end

	local function double(n)
		return n * 2
	end

	local addThenDouble = pipe(addOne, double)
	print(addThenDouble(2)) -- prints 6 ((2 + 1) * 2)
	```
]=]

local Dash = script.Parent
local Types = require(Dash.Types)

local function pipe(...: { Types.AnyFunction }): Types.AnyFunction
	local funcs = { ... }
	local length = #funcs

	-- Validate all arguments are functions
	for i = 1, length do
		if type(funcs[i]) ~= "function" then
			error("Expected a function", 2)
		end
	end

	return function(...)
		if length == 0 then
			return ...
		end

		local result = { funcs[1](...) }
		for i = 2, length do
			result = { funcs[i](unpack(result)) }
		end
		return unpack(result)
	end
end

return pipe
