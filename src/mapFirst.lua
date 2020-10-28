local function mapFirst(input, fn)
	for key, child in ipairs(input) do
		local output = fn(child, key)
		if output ~= nil then
			return output
		end
	end
end
return mapFirst