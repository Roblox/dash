--[[
	Omit from the `input` map any entries with keys included in the `keys` array.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local forEachPairs = require(Dash.forEachPairs)
local includes = require(Dash.includes)

-- TODO: Add Generics by replacing the line below with:
-- local function omit<Key, Value>(input: Types.Map<Key, Value>, keys: Types.Array<Key>): Value
local function omit(input: Types.Map<Key, Value>, keys: Types.Array<Key>): Value
	local output = {}
	forEachPairs(input, function(child, key)
		if not includes(keys, key) then
			output[key] = input[key]
		end
	end)
	return output
end

return omit