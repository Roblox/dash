local assign = require(script.Parent.assign)

local function copy(input)
	return assign({}, input)
end
return copy