local function getOrSet(input, key, getValue)
	if input[key] == nil then
		input[key] = getValue(input, key)
	end
	return input[key]
end
return getOrSet