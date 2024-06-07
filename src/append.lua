--[[
	Adds new elements to the _target_ Array from subsequent Array arguments in left-to-right order.

	Arguments which are `nil` or None are skipped.

	@mutable target
]]

local Dash = script.Parent
local None = require(Dash.None)
local Types = require(Dash.Types)
local forEachArgs = require(Dash.forEachArgs)
local forEach = require(Dash.forEach)
local insert = table.insert

local function append(target: { unknown }, ...: { unknown }?): { unknown }
	forEachArgs(function(list: Types.Table?)
		-- TODO (AleksandrSl 29/05/2024): Add wrapper function for this.
		if list == None or list == nil then
			return
		end
		forEach(list, function(value: any)
			insert(target, value)
		end)
	end, ...)
	return target
end

return append
