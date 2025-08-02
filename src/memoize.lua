--[=[
	Creates a function that memoizes the result of `func`. The memoized function will cache
	results based on the arguments provided. If a resolver function is provided, it will be
	used to generate the cache key from the arguments.

	@param func function -- The function to memoize
	@param resolver function? -- Optional function to resolve the cache key
	@return function -- Returns the memoized function

	@example
	```lua
	local function add(a: number, b: number): number
		return a + b
	end

	local memoizedAdd = memoize(add)
	print(memoizedAdd(1, 2)) -- Calculates and caches: 3
	print(memoizedAdd(1, 2)) -- Returns from cache: 3

	-- With custom resolver
	local memoizedWithResolver = memoize(add, function(a: number, b: number): string
		return string.format("%d_%d", a, b)
	end)
	```
]=]

local Dash = script.Parent
local Types = require(Dash.Types)

export type ResolverFunction = (...any) -> string

local function memoize<T...>(func: Types.AnyFunction, resolver: ResolverFunction?): Types.AnyFunction
	local cache = {}

	return function(...: T...): any
		local args = table.pack(...)
		local key: string

		if resolver then
			key = resolver(...)
		else
			-- Create a cache key from all arguments
			key = ""
			for i = 1, args.n do
				key = key .. tostring(args[i]) .. "|"
			end
		end

		if cache[key] == nil then
			cache[key] = func(...)
		end

		return cache[key]
	end
end

return memoize
