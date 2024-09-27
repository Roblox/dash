local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local all = Dash.all

describe("all", function()
	it("should return true if all elements match", function()
		local input = { aa = 5, ab = 5, ac = 5, ad = 5 }
		local output = all(input, function(value, key)
			return string.sub(key, 1, 1) == "a" and value == 5
		end)
		expect(output).toBe(true)
	end)

	it("should return false if at least one element doesn't match", function()
		local input = { aa = 5, ab = 5, bc = 5, ad = 5 }
		local output = all(input, function(value, key)
			return string.sub(key, 1, 1) == "a" and value == 5
		end)
		expect(output).toBe(false)
	end)

	describe("condition function is not given", function()
		it("should return true if all values are truthy", function()
			local input = { a = 5, b = 5, c = 5, d = 0 }
			local output = all(input)
			expect(output).toBe(true)
		end)

		it("should return false if at least one value is falsy", function()
			local input = { a = 5, b = 5, c = 5, d = false }
			local output = all(input)
			expect(output).toBe(false)
		end)
	end)
end)
