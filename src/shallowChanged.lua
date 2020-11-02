local function shallowChanged(left, right)
	if left == right then
		return false
	end
	if typeof(left) ~= "table" or typeof(right) ~= "table" or #left ~= #right then
		return true
	end
	if left == nil or right == nil then
		return true
	end
	for key, value in pairs(left) do
		if right[key] ~= value then
			return true
		end
	end
	for key, value in pairs(right) do
		if left[key] ~= value then
			return true
		end
	end
	return false
end

return shallowChanged
