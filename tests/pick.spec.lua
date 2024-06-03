local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local pick = Dash.pick

describe("pick", function()
	it("should pick elements in a map by key or value", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = pick(input, function(value, key)
			return key == "b" or value == 30
		end)
		expect(output).toEqual({ b = 20, c = 30 })
	end)
end)
