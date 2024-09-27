local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local forEachArgs = Dash.forEachArgs

local insert = table.insert

describe("forEachArgs", function()
	it("should iterate through elements of an array", function()
		local output = {}
		local function test(...)
			forEachArgs(function(value, key)
				insert(output, key + value)
			end, ...)
		end
		test(1, 2, 3, 4, 5)
		expect(output).toEqual({ 2, 4, 6, 8, 10 })
	end)
end)
