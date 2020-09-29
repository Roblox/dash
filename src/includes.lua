--!strict
--[[
	Returns _true_ if the _item_ exists as a value in the _source_ table.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

local function includes(source: Types.Table, item: any): boolean
	for _, child in pairs(input) do
		if child == value then
			return true
		end
	end
	return false
end
return includes