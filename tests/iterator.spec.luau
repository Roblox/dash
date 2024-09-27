local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local iterable = Dash.iterable
local iterator = Dash.iterator
local slice = Dash.slice

local insert = table.insert
local sort = table.sort

describe("iterator", function()
	it("iterates through an array in order", function()
		local output = {}
		for key, value in iterator({ 10, 20, 30, 40, 50 }) do
			insert(output, key .. "=" .. value)
		end
		expect(output).toEqual({
			"1=10",
			"2=20",
			"3=30",
			"4=40",
			"5=50",
		})
	end)

	it("iterates through a map in an arbitrary order", function()
		local output = {}
		for key, value in iterator({ a = 1, b = 2, c = 3, d = 4, e = 5 }) do
			insert(output, key .. "=" .. value)
		end
		sort(output)
		expect(output).toEqual({
			"a=1",
			"b=2",
			"c=3",
			"d=4",
			"e=5",
		})
	end)

	it("only discovers ordered keys as ipairs assumed", function()
		local output = {}
		for key, value in iterator({ [1] = 10, [2] = 20, [3] = 30, [5] = 50, a = 1, b = 2, c = 3, d = 4, e = 5 }) do
			insert(output, key .. "=" .. value)
		end
		sort(output)
		expect(output).toEqual({
			"1=10",
			"2=20",
			"3=30",
		})
	end)

	it("discovers unordered keys if forced", function()
		local input = iterable({ [1] = 10, [2] = 20, [3] = 30, [5] = 50, a = 1, b = 2, c = 3, d = 4, e = 5 })
		local output = {}
		for key, value in iterator(input) do
			insert(output, key .. "=" .. value)
		end
		expect(slice(output, 1, 3)).toEqual({
			"1=10",
			"2=20",
			"3=30",
		})
		sort(output)
		expect(output).toEqual({
			"1=10",
			"2=20",
			"3=30",
			"5=50",
			"a=1",
			"b=2",
			"c=3",
			"d=4",
			"e=5",
		})
	end)
end)
