local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local sum = Dash.sum

describe("sum", function()
	it("should return sum of all array elements", function()
		local input = { -10, 10, 0 }
		local output = sum(input)
		expect(output).toEqual(0)
	end)

	it("should return 0 if array is empty", function()
		local input = {}
		local output = sum(input)
		expect(output).toEqual(0)
	end)
end)
