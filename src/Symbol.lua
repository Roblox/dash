--!strict
--[[
	Create a symbol with a specified name. We recommend upper snake-case as the symbol is a
	constant, unless you are linking the symbol conceptually to a different string.

	Symbols are useful when you want a value that isn't equal to any other type, for example if you
	want to store a unique property on an object that won't be accidentally accessed with a simple
	string lookup.

	@example
	local CHEESE = Symbol.new("CHEESE")
	local FAKE_CHEESE = Symbol.new("CHEESE")
	print(CHEESE == CHEESE) --> true
	print(CHEESE == FAKE_CHEESE) --> false
	print(tostring(CHEESE)) --> "Symbol.new(CHEESE)"
]]
local Symbol = {}

function Symbol:__tostring(): string
	return ("Symbol(%s)"):format(self.name)
end

function Symbol:__newindex(_, key: any)
	error(string.format("ReadonlyKey: Attempt to write to a frozen key %s", key))
end

--[[
	Return true if the value passed in is a Symbol instance.
]]
function Symbol.is(value: any): boolean -- value is Symbol
	return getmetatable(value) == Symbol
end

--[[
	Create a new symbol instance.
]]
function Symbol.new(name: string): Symbol
	local symbol = {
		name = name
	}
	return setmetatable(symbol, Symbol)
end

-- TODO Luau: Define class types automatically
export type Symbol = typeof(Symbol.new(""))

return Symbol