--!strict
local function findIndex(input, fn)
	for key, child in ipairs(input) do
		if fn(child, key) then
			return key
		end
	end
end
return findIndex