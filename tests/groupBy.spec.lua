local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local groupBy = Dash.groupBy

describe("groupBy", function()
	it("should return an empty table for an empty grouping", function()
		local output = groupBy({}, function()
			return 5
		end)
		expect(output).toEqual({})
	end)

	it("should return a table with a single group for aliased keys", function()
		local output = groupBy({ 1, 2, 3, 4, 5 }, function()
			return 5
		end)
		expect(output).toEqual({
			[5] = {
				1,
				2,
				3,
				4,
				5,
			},
		})
	end)

	it("should return a table with a separate groups for unique keys", function()
		local output = groupBy({ 1, 2, 3, 4, 5 }, function(_, key)
			return key
		end)
		expect(output).toEqual({
			{
				1,
			},
			{
				2,
			},
			{
				3,
			},
			{
				4,
			},
			{
				5,
			},
		})
	end)

	it("should allow groups of mixed sizes produced from combining handler arguments", function()
		local output = groupBy({ 5, 4, 3, 4, 5 }, function(child, key)
			return child + key
		end)
		expect(output).toEqual({ [6] = {
			5,
			4,
			3,
		}, [8] = {
			4,
		}, [10] = {
			5,
		} })
	end)

	it("should perform grouping for maps and a getKey string", function()
		local output = groupBy({
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
				{
					color = "blue",
					name = "bike",
				},
			},
			red = {
				{
					color = "red",
					name = "car",
				},
			},
			white = {
				{
					color = "white",
					name = "van",
				},
			},
		})
	end)
end)
