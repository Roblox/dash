local Dash = {}

local Types = require(script.Types)

-- A table with values of type _Value_ and numeric keys 1..n with no gaps
export type Array<Value> = Types.Array<Value>
-- A table with values of type _Value_ and numeric keys, possibly with gaps
export type Args<Value> = Types.Args<Value>
-- A table with keys of type _Key_ and values of type _Value_
export type Map<Key, Value> = Types.Map<Key, Value>
-- A table with keys of a fixed type _Key_ and a boolean value representing membership of the set (default is false)
export type Set<Key> = Types.Set<Key>
-- A table of any type
export type Table = Types.Table
-- A class has a constructor returning an instance of _Object_ type
export type Class<Object> = Types.Class<Object>

-- Represents a function which takes any arguments and returns any value
export type AnyFunction = Types.AnyFunction

-- Require and add the Dash functions to the Dash table
for _, fn in pairs(script:GetChildren()) do
	Dash[fn.Name] = require(fn)
end

return Dash.freeze("Dash", Dash, true)
