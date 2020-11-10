local function some(input, fn)
	for key, child in pairs(input) do
		if fn(child, key) then
			return true
		end
	end
	return false
end
return some