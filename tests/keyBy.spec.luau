local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local keyBy = Dash.keyBy

describe("keyBy", function()
	it("should return an empty table for an empty grouping", function()
		local output = keyBy({}, function()
			return 5
		end)
		expect(output).toEqual({})
	end)

	it("should return the most recent value for aliased keys", function()
		local output = keyBy({ 1, 2, 3, 4, 5 }, function(_, index)
			return index % 2
		end)
		expect(output).toEqual({
			[1] = 5,
			[0] = 4,
		})
	end)

	it("should return a table with a separate entries for unique keys", function()
		local output = keyBy({ 1, 2, 3, 4, 5 }, function(_, key)
			return key
		end)
		expect(output).toEqual({
			1,
			2,
			3,
			4,
			5,
		})
	end)

	it("should perform assignment for maps and a getKey string", function()
		local output = keyBy({
			bike = {
				name = "bike",
				color = "blue",
			},
			car = {
				name = "car",
				color = "red",
			},
			van = {
				name = "van",
				color = "white",
			},
			ghost = {
				name = "ghost",
			},
		}, "color")
		expect(output).toEqual({
			blue = {
				color = "blue",
				name = "bike",
			},
			red = {
				color = "red",
				name = "car",
			},
			white = {
				color = "white",
				name = "van",
			},
		})
	end)
end)
