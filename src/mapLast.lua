--[[
	Iterates through the elements of the _input_ Array in reverse in order n..1.

	Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

-- TODO Luau: Support generic functions
export type MapHandler = (any, number) -> any

local function mapLast(input: Types.Array<any>, handler: MapHandler)
	for key = #input, 1, -1 do
		local child = input[key]
		local output = handler(child, key)
		if output ~= nil then
			return output
		end
	end
	return
end
return mapLast
