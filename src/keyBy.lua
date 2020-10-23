local Dash = script.Parent
local collect = require(Dash.collect)

local insert = table.insert

local function keyBy(input, keyOrFn)
	return collect(input, function(key, child)
		local newKey
		if typeof(keyOrFn) == "string" then
			newKey = child[keyOrFn]
		else
			newKey = keyOrFn(child, key)
		end
		return newKey, child
	end)
end
return keyBy