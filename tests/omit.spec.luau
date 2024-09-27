local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local omit = Dash.omit

describe("omit", function()
	it("should omit entries from a map based on key", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = omit(input, { "a", "b" })
		expect(output).toEqual({ c = 30, d = 50 })
	end)
end)
