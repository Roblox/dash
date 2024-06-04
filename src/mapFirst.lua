--[[
	Iterates through the elements of the _input_ Array in order 1..n.

	Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: Support generic functions
export type MapHandler = (any, number) -> any

local function mapFirst(input: Types.Array<any>, handler: MapHandler)
	for index, child in ipairs(input) do
		local output = handler(child, index)
		if output ~= nil then
			return output
		end
	end
	return
end
return mapFirst
