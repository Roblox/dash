local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local findIndex = Dash.findIndex

describe("findIndex", function()
	it("should find an element in a table by index", function()
		local input = { 10, 20, 30, 40 }
		local output = findIndex(input, function(_value, index)
			return index == 2
		end)
		expect(output).toEqual(2)
	end)

	it("should find an element in a table by value", function()
		local input = { 10, 20, 30, 40 }
		local output = findIndex(input, function(value)
			return value == 20
		end)
		expect(output).toEqual(2)
	end)

	it("should not find an element which does not exist", function()
		local input = { 10, 20, 30, 40 }
		local output = findIndex(input, function(_value, index)
			return index == 10
		end)
		expect(output).toBeNil()
	end)
end)
