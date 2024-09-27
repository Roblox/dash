local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local flat = Dash.flat

describe("flat", function()
	it("should flatten an array correctly", function()
		local input = { { 10, 20 }, { 30, 40 }, { 50, { 60 } } }
		local output = flat(input)
		expect(output).toEqual({
			10,
			20,
			30,
			40,
			50,
			{
				60,
			},
		})
	end)
end)
