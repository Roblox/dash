local Source = script.Parent.Parent
local assign = require(Source.Utils.assign)

local function copy(input)
	return assign({}, input)
end
return copy