--[[
	Reverse the order of the elements in the _input_ array.
]]

local insert = table.insert

local function reverse(input: { any }): { any }
	local output = {}
	for i = #input, 1, -1 do
		insert(output, input[i])
	end
	return output
end
return reverse
