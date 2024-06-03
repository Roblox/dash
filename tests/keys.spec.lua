local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local keys = Dash.keys

local sort = table.sort

describe("keys", function()
	it("should return an empty table for an empty map", function()
		local output = keys({})
		expect(output).toEqual({})
	end)

	it("should return a list of the keys of an array", function()
		local output = keys({ 10, 20, 30, 40, 50 })
		sort(output)
		expect(output).toEqual({
			1,
			2,
			3,
			4,
			5,
		})
	end)

	it("should return a list of the keys of a map", function()
		local output = keys({ a = 10, b = 20, c = 30, d = 40, e = 50 })
		sort(output)
		expect(output).toEqual({
			"a",
			"b",
			"c",
			"d",
			"e",
		})
	end)
end)
