local Dash = script.Parent
local Types = require(Dash.Types)

type AllHandler = (any, any) -> boolean

local defaultHandler = function(value)
	return value
end

local function all(input: Types.Table, handler: AllHandler?): boolean
	handler = if handler then handler else defaultHandler
	for key, value in input do
		if not handler(value, key) then
			return false
		end
	end
	return true
end

return all
