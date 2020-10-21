--!strict
--[[
	Output a new Table from merging all the keys in the Table arguments in left-to-right order.

	The None symbol can be used to remove existing elements.

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