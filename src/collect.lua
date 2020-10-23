local function collect(input, fn)
	local result = {}
	for key, child in pairs(input) do
		local outputKey, outputValue = fn(key, child)
		if outputKey ~= nil then
			result[outputKey] = outputValue
		end
	end
	return result
end
return collect