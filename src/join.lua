--!strict
--[[
	Like `dash.assign` but outputs a new table from merging all the keys in the inputs.
	@param ... any number of tables
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assign = require(Dash.assign)

-- TODO Luau: Support typing varargs
-- TODO Luau: Support function generics
local function join(...): types.Table
	return assign({}, ...)
end

return join