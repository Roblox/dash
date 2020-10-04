--!strict
local Dash = script.Parent
local forEach = require(Dash.forEach)
local None = require(Dash.None)
local insert = table.insert

local function append(target, ...)
	local lists = {...}
	for i = 1, select("#", ...) do
		local list = lists[i]
		if list == None or list == nil then
			continue
		end
		forEach(list, function(value)
			insert(target, value)
		end)
	end
	return target
end

return append