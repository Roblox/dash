--[[
	Returns a value of the _input_ Table at the _key_ provided.

	If the key is missing, the value is acquired from the _getValue_ handler,
	added to the _input_ Table and returned.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: Support generic functions
export type GetValueHandler = (Types.Table, any) -> any

local function getOrSet(input: Types.Table, key: any, getValue: GetValueHandler)
	if input[key] == nil then
		input[key] = getValue(input, key)
	end
	return input[key]
end
return getOrSet
