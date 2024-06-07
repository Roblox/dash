local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local reduce = Dash.reduce

describe("reduce", function()
	it("should reduce entries from an array using the handler and value", function()
		local output = reduce({ 10, 20, 30, 40 }, function(a, b)
			return a + b
		end, 0)
		expect(output).toEqual(100)
	end)

	it("should reduce entries from an array using the handler and key", function()
		local output = reduce({ 10, 20, 30, 40 }, function(acc, _, key)
			return acc .. key .. ","
		end, "")
		expect(output).toEqual("1,2,3,4,")
	end)
end)
