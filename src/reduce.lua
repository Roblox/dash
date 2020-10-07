
--!strict
local Dash = script.Parent
local Types = require(Dash.Types)

local function reduce(list: Types.Array<any>, handler, initial)
	local result = initial
	if not list then
		return nil
	end
	for i = 1, #list do
		result = handler(result, list[i], i)
	end
	return result
end

return reduce