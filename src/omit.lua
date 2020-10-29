--[[
	Omit from the `input` map any entries with keys included in the `keys` array.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local forEachPairs = require(Dash.forEachPairs)
local includes = require(Dash.includes)

-- TODO Luau: Support generic functions, then substitute type signature
-- TYPED: local function omit<Key, Value>(input: Types.Map<Key, Value>, keys: Types.Array<Key>): Value
local function omit(input: any, keys: any): any
	local output = {}
	-- TYPED: forEachPairs(input, function(child: Value, key: Key)
	forEachPairs(input, function(child, key)
		if not includes(keys, key) then
			output[key] = input[key]
		end
	end)
	return output
end

return omit