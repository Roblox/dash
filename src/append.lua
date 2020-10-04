--!strict
local Source = script.Parent.Parent
local forEach = require(Source.Utils.forEach)
local None = require(Source.Symbols.None)
local insert = table.insert

local function append(target, ...)
	local lists = {...}
	for i = 1, select("#", ...) do
		local list = lists[i]
		if list == None or list == nil then
			continue
		end
		forEach(list, function(value)
			local pretty = require(Source.Utils.pretty)
			insert(target, value)
		end)
	end
	return target
end

return append