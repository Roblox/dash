--!strict
--[[
	Iterates through the tail arguments in order, including nil values up to the argument list length.
	Calls the _handler_ for each entry.
]]

export type ForEachArgsHandler<Value> = (Value, number) -> ()
-- TODO Luau: Support function generics
-- TODO Luau: Support vararg types
--local function forEachArgs<Value>(handler: ForEachArgsHandler<Value>, ...: Types.Args<Value>)
local function forEachArgs(handler: ForEachArgsHandler<Value>, ...)
	for index = 1, select('#', ...) do
		handler(select(index, ...), index)
	end
end
return forEachArgs