local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local append = Dash.append
local None = Dash.None

describe("append", function()
	it("should append to an empty list", function()
		expect(append({}, { 1, 2, 3 }, { 4, 5, 6 })).toEqual({ 1, 2, 3, 4, 5, 6 })
	end)

	it("should append to a list with existing values", function()
		expect(append({ 1, 2 }, { 3 }, { 4, 5, 6 })).toEqual({ 1, 2, 3, 4, 5, 6 })
	end)

	it("should skip nil arguments", function()
		expect(append({ 1, 2 }, nil, nil, { 4, 5, 6 })).toEqual({ 1, 2, 4, 5, 6 })
	end)

	it("should skip None arguments", function()
		expect(append({ 1, 2 }, None, None, { 4, 5, 6 })).toEqual({ 1, 2, 4, 5, 6 })
	end)

	it("should share a reference between input and output", function()
		local input = { 1, 2 }
		local output = append(input, { 1, 2, 3 }, { 4, 5, 6 })
		expect(input).toEqual(output)
	end)
end)
