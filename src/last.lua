--[[
	Return the last element of `list`.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

local function last(list: Types.Array<any>)
	if list == nil then
		return nil
	else
		return list[#list]
	end
end

return last