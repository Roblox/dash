local Dash = script.Parent
local Types = require(Dash.Types)
local insert = table.insert

local function slice(list: Types.Array<any>, left: number, right: number?)
	local output = {}
	for i = left, right or #list do
		insert(output, list[i])
	end
	return output
end

return slice