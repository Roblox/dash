local function mapFirst(input, fn)
	for key = #input, 1, -1 do
		local child = input[key]
		local output = fn(child, key)
		if output ~= nil then
			return output
		end
	end
end
return mapFirst