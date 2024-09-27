local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local reverse = Dash.reverse

describe("reverse", function()
	it("should reverse the order of an array without modifying the input", function()
		local input = { 10, 20, 30, 40 }
		local output = reverse(input)
		expect(input).toEqual({ 10, 20, 30, 40 })
		expect(output).toEqual({ 40, 30, 20, 10 })
	end)
end)
