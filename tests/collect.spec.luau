local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local collect = Dash.collect

describe("collect", function()
	it("should collect elements of an array", function()
		local input = { 10, 20, 30, 50 }
		local output = collect(input, function(key, value)
			return value, key
		end)
		expect(output).toEqual({ [10] = 1, [20] = 2, [30] = 3, [50] = 4 })
	end)

	it("should collect elements of a map", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = collect(input, function(key, value)
			return value + 1, key .. "!"
		end)
		expect(output).toEqual({ [11] = "a!", [21] = "b!", [31] = "c!", [51] = "d!" })
	end)
end)
