local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Lua: Support generic functions
export type MapHandler = (any, number) -> any

-- TYPED: export type MapHandler<Input, Output> = (Value, number) -> Output
-- TYPED: local function map<Input, Output>(input: Types.Array<Input>, fn: MapFn<Input, Output>)<Output>

local function map(input: Types.Array<any>, fn: MapHandler): Types.Array<any>
	local result = {}
	for key, child in ipairs(input) do
		result[key] = fn(child, key)
	end
	return result
end
return map