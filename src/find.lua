--!strict
local function find(input, fn)
	for key, child in ipairs(input) do
		if fn(child, key) then
			return child
		end
	end
end
return find