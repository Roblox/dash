local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local copy = Dash.copy
local pretty = Dash.pretty

describe("copy", function()
	it("should make a shallow copy of a table", function()
		local input = { a = 10, b = 20, c = 30, reference = { 50 } }
		local output = copy(input)
		expect(input).never.toBe(output)
		expect(pretty(input)).toEqual(pretty(output))
		expect(input.reference).toBe(output.reference)
	end)
end)
