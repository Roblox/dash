--!strict
local function find(input, fn)
	for key, child in pairs(input) do
		if fn(child, key) then
			return child
		end
	end
end
return find