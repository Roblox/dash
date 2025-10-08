local Dash = script.Parent
local None = require(Dash.None)
local Types = require(Dash.Types)
local forEach = require(Dash.forEach)
local forEachArgs = require(Dash.forEachArgs)

--[=[
	Adds new key/value pairs to the _target_ table from subsequent table arguments in left-to-right order.

	The `None` symbol can be used to remove existing elements in _target_. `nil` or `None` arguments are skipped.

	@param target The table to assign into.
	@param ... One or more tables whose entries will be assigned to _target_.
	@return The mutated _target_ table.

	@example
	```luau
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
	```
]=]

local function merge(a: {}, b: {}?)
	if b == nil or b == None then
		return
	end

	for key, value in b do
		if value == None then
			a[key] = nil
		else
			a[key] = value
		end
	end
end

local function assign(target: {}, dict1: {}?, ...: {}?): Types.Table
	if dict1 ~= nil and dict1 ~= None then
		merge(target, dict1)
	end

	local tupleSize = select("#", ...)
	if tupleSize <= 1 then
		return target
	end

	for index = 1, tupleSize do
		local dict = select(index, ...)
		if dict and dict ~= None then
			merge(target, dict)
		end
	end

	return target
end

return assign
