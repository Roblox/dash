local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local joinArrays = Dash.joinArrays

describe("join", function()
	it("should join arrays together", function()
		expect(joinArrays({ "cherry" }, { "apple" }, { "banana", "durian" })).toEqual({
			"cherry",
			"apple",
			"banana",
			"durian",
		})
	end)

	it("should skip nil arguments", function()
		expect(joinArrays({ "apple", "banana" }, nil, nil, { "cherry" })).toEqual({
			"apple",
			"banana",
			"cherry",
		})
	end)

	it("should not mutate the original input", function()
		local input = { "apple", "banana" }
		expect(joinArrays(input, { "cherry" }, { "durian" })).toEqual({
			"apple",
			"banana",
			"cherry",
			"durian",
		})
		expect(input).toEqual({
			"apple",
			"banana",
		})
	end)
end)
