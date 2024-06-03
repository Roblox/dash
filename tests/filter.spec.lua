local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local filter = Dash.filter

local sort = table.sort

describe("filter", function()
	it("should filter elements in an array", function()
		local input = { 1, 2, 3, 4 }
		local output = filter(input, function(index, value)
			return index == 2 or value == 3
		end)
		expect(output).toEqual({ 2, 3 })
	end)

	it("should filter an element in a table by key or value", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = filter(input, function(value, key)
			return key == "b" or value == 30
		end)
		sort(output)
		expect(output).toEqual({ 20, 30 })
	end)
end)
