local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)

local includes = Dash.includes

describe("includes", function()
	it("should return the expected value for arrays", function()
		expect(includes({ 1, 2, 3, 4, 5 }, 5)).toBe(true)
		expect(includes({ 1, 2, 3, 4, 5 }, 6)).toBe(false)
	end)

	it("should return the expected value for maps", function()
		expect(includes({ a = 1, b = 5, c = 3 }, 5)).toBe(true)
		expect(includes({ k = "10", l = 0, [0] = 9 }, "10")).toBe(true)
		expect(includes({ a = 1, b = 5, c = 3 }, 6)).toBe(false)
	end)

	it("should return false for nil", function()
		expect(includes({ a = nil }, nil)).toBe(false)
	end)
end)
