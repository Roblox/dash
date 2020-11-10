--[[
	Collect returns a new Array derived from _input_ by iterating through its pairs and calling
	the handler on each `(key, child)` tuple. 

	The handler should return a new value to be pushed onto the end of the result array, or `nil`
	if no value should be added.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

local insert = table.insert
local insert = table.insert

-- TODO Luau: Support generic functions
local function collectArray(input: Types.Table, handler: Types.AnyFunction)
	assertEqual(typeof(input), "table", [[Attempted to call Dash.collectArray with argument #1 of type {left:?} not {right:?}]])
	local result = {}
	for key, child in pairs(input) do
		local outputValue = handler(key, child)
		if outputValue ~= nil then
			insert(result, outputValue)
		end
	end
	return result
end
return collectArray