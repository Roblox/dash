local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local find = Dash.find

describe("find", function()
	it("should find the first element in an array by index", function()
		local input = { 10, 20, 30, 40 }
		local output = find(input, function(_value, index)
			return index > 2
		end)
		expect(output).toEqual(30)
	end)

	it("should find the first element in an array by value", function()
		local input = { 10, 20, 30, 40 }
		local output = find(input, function(value)
			return value > 20
		end)
		expect(output).toEqual(30)
	end)

	it("should find an element in a table by key", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = find(input, function(_value, key)
			return key == "b"
		end)
		expect(output).toEqual(20)
	end)

	it("should find an element in a table by value", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = find(input, function(value)
			return value == 20
		end)
		expect(output).toEqual(20)
	end)

	it("should not find an element which does not exist", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = find(input, function(_value, key)
			return key == "f"
		end)
		expect(output).toBeNil()
	end)
end)
