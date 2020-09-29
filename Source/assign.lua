--!strict
--[[
	Adds new elements to _target_ from subsequent table arguments in order, with elements in later
	tables replacing earlier ones if their keys alias.
	@param ... any number of other tables
	@example
	local characters = {
		Frodo = {
			name = "Frodo Baggins",
			team = "blue"
		},
		Boromir = {
			score = 5
		}
	}
	local otherCharacters = {
		Frodo = {
			team = "red",
			score = 10
		},
		Bilbo = {
			team = "yellow",
		},
		Boromir = {
			score = {1, 2, 3}
		}
	}
	local result = assign(characters, otherCharacters)
	print(result) --> {
		Frodo = {
			team = "red",
			score = 10
		},
		Bilbo = {
			team = "yellow"
		},
		Boromir = {
			score = {1, 2, 3}
		}
	}
]]
local Dash = script.Parent
local None = require(Dash.None)
local Types = require(Dash.Types)
local forEachPairs = require(Dash.forEachPairs)

-- TODO Luau: Support typing varargs
-- TODO Luau: Support function generics
local function assign(target: Types.Table, ...): Types.Table
	-- Iterate through the varags in order
	forEachArgs(function(input: types.Table?)
		-- Ignore items which are not defined
		if input == nil or input == None then
			return
		end
		-- Iterate through each key of the input and assign to target at the same key
		forEachPairs(input, function(value, key)
			target[key] = value
		end)
	end, ...)
	return target
end

return assign