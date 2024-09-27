local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local isCallable = Dash.isCallable

describe("isCallable", function()
	it("should return the expected value for a range of inputs", function()
		local callable = {}
		setmetatable(callable, {
			__call = function() end,
		})
		expect(isCallable(26)).toBe(false)
		expect(isCallable(false)).toBe(false)
		expect(isCallable("hoop")).toBe(false)
		expect(isCallable({})).toBe(false)
		expect(isCallable(function() end)).toBe(true)
		expect(isCallable(callable)).toBe(true)
	end)
end)
