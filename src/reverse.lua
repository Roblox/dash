--[[
	Reverse the order of the elements in the _input_ Array.
]]

local Dash = script.Parent
local Types = require(Dash.Types)

local insert = table.insert

local function reverse(input: Types.Array<any>): Types.Array<any>
	local output = {}
	for i = #input, 1, -1 do
		insert(output, input[i])
	end
	return output
end
return reverse
