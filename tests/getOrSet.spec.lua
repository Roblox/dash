local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local getOrSet = Dash.getOrSet

describe("getOrSet", function()
	it("should return an existing value", function()
		local function throw()
			error("This should not be called")
		end
		expect(getOrSet({ a = 2 }, "a", throw)).toEqual(2)
	end)

	it("should set a new value", function()
		local function getValue(input, key)
			return input.a + key
		end
		local output = { a = 5 }
		expect(getOrSet(output, 8, getValue)).toEqual(13)
		expect(output).toEqual({ [8] = 13, a = 5 })
	end)
end)
