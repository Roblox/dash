local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local values = Dash.values

local sort = table.sort

describe("values", function()
	it("should return an empty table for an empty map", function()
		local output = values({})
		expect(output).toEqual({})
	end)

	it("should return a list of the values of an array", function()
		local output = values({ 10, 30, 20, 40, 50 })
		expect(output).toEqual({ 10, 30, 20, 40, 50 })
	end)

	it("should return a list of the values of a map", function()
		local output = values({ a = 10, b = 20, c = 30, d = 40, e = 50 })
		sort(output)
		expect(output).toEqual({ 10, 20, 30, 40, 50 })
	end)
end)
