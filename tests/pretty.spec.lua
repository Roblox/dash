local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local pretty = Dash.pretty

describe("pretty", function()
	it("should print primitive values", function()
		expect(pretty("stringy")).toEqual([["stringy"]])
		expect(pretty(15)).toEqual([[15]])
		expect(pretty(true)).toEqual([[true]])
		local function myFunction() end
		expect(pretty(myFunction)).toEqual(tostring(myFunction))
	end)

	it("should print a map with string keys", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = pretty(input)
		expect(output).toEqual([[{a = 10, b = 20, c = 30, d = 50}]])
	end)

	it("should print an array", function()
		local input = { 10, 20, 30, 50 }
		local output = pretty(input)
		expect(output).toEqual([[{10, 20, 30, 50}]])
	end)
end)
