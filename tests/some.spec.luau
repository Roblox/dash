local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local some = Dash.some

describe("some", function()
	it("should return true if an element matches", function()
		local input = { a = 5, b = 6, c = 7, d = 8 }
		local output = some(input, function(value, key)
			return key == "c" or value == 3000
		end)
		expect(output).toBe(true)
	end)

	it("should return false if no element matches", function()
		local input = { a = 5, b = 6, c = 7, d = 8 }
		local output = some(input, function(_, key)
			return key == "No such key"
		end)
		expect(output).toBe(false)
	end)
end)
