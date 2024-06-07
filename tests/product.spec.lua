local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local product = Dash.product

describe("product", function()
	it("should return product of all array elements", function()
		local input = { 2, 3, 7 }
		local output = product(input)
		expect(output).toEqual(42)
	end)

	it("should return 1 if array is empty", function()
		local input = {}
		local output = product(input)
		expect(output).toEqual(1)
	end)
end)
