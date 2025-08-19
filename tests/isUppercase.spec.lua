local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local isUppercase = Dash.isUppercase

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("isUppercase", function()
	it("should return the expected value for a range of inputs", function()
		local callable = {}
		setmetatable(callable, {
			__call = function() end,
		})
		expect(isUppercase("hello")).toBe(false)
		expect(isUppercase("Hello")).toBe(true)
		-- Unfortunately not supported in the current version of Lua
		-- expect(isUppercase("êcho")).toBe(false)
		-- expect(isUppercase("Êcho")).toBe(true)
	end)

	it("ensures input is not an empty string", function()
		expect(function()
			isUppercase("")
		end).toThrowWithMessage("AssertError: Attempted to call Dash.isUppercase with an empty string")
	end)
end)
