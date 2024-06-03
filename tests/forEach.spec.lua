local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local forEach = Dash.forEach

local insert = table.insert
local sort = table.sort

describe("forEach", function()
	it("should iterate through elements of an array", function()
		local output = {}
		forEach({ 1, 2, 3, 4, 5 }, function(value, key)
			insert(output, key + value)
		end)
		expect(output).toEqual({ 2, 4, 6, 8, 10 })
	end)

	it("should iterate through elements of a map", function()
		local output = {}
		forEach({ a = 1, b = 2, c = 3 }, function(value, key)
			insert(output, key .. "=" .. value)
		end)
		sort(output)
		expect(output).toEqual({ "a=1", "b=2", "c=3" })
	end)
end)
