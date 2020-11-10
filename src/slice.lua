local Dash = script.Parent
local Types = require(Dash.Types)
local insert = table.insert

local function slice(list: Types.Array<any>, left: number, right: number?)
	local output = {}
	if left and left < 0 then
		left = #list + left
	end
	if right and right < 0 then
		right = #list + right
	end
	for i = left or 1, right or #list do
		insert(output, list[i])
	end
	return output
end

return slice