local insert = table.insert

local function reverse(source)
	local output = {}
	for i = #source, 1, -1 do
		insert(output, source[i])
	end
	return output
end
return reverse