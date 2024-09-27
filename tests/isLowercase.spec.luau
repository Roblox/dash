local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local isLowercase = Dash.isLowercase

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("isLowercase", function()
	it("should return the expected value for a range of inputs", function()
		local callable = {}
		setmetatable(callable, {
			__call = function() end,
		})
		expect(isLowercase("hello")).toBe(true)
		expect(isLowercase("Hello")).toBe(false)
		-- Unfortunately not supported in the current version of Lua
		-- expect(isLowercase("êcho")).toBe(true)
		-- expect(isLowercase("Êcho")).toBe(false)
	end)

	it("ensures input is not an empty string", function()
		expect(function()
			isLowercase("")
		end).toThrowWithMessage("AssertError: Attempted to call Dash.isLowercase with an empty string")
	end)
end)
