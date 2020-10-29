local Dash = script.Parent
local Types = require(Dash.Types)
local assign = require(Dash.assign)

local function copy(input: Types.Table)
	return assign({}, input)
end
return copy