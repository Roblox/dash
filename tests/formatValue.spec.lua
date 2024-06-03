local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local formatValue = Dash.formatValue

describe("formatValue", function()
	it("should provide a default format for a range of input types", function()
		expect(formatValue("Hello world")).toEqual("Hello world")
		expect(formatValue(255.0)).toEqual("255")
		expect(formatValue(255.3)).toEqual("255.300000")
	end)
	it("should format a range of input types using displayString", function()
		expect(formatValue(255, "s")).toEqual("255")
		expect(formatValue(255, "06X")).toEqual("0000FF")
		expect(formatValue({ a = 2, b = { 2, 3 } }, "?")).toEqual("{a = 2, b = {2, 3}}")
		expect(formatValue({ a = 2, b = { 2, 3 } }, "#?")).toEqual([[{
	a = 2,
	b = {
		2,
		3
	}
}]])
	end)
end)
