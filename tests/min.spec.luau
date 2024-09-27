local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local min = Dash.min

describe("min", function()
	describe("with default handler and comparator", function()
		it("should get minimal element", function()
			local input = { 20, 50, -20, 30, 10 }
			local output = min(input)
			expect(output).toEqual(-20)
		end)
	end)

	describe("with custom comparator and default handler", function()
		it("should get minimal element", function()
			-- Yes, pun intended
			local function customComparator(a, b)
				return a > b
			end

			local input = { 20, 50, -20, 30, 10 }
			local output = min(input, nil, customComparator)
			expect(output).toEqual(50)
		end)
	end)

	describe("with custom comparator and custom handler", function()
		it("should get minimal element", function()
			-- Yes, pun intended
			local function customComparator(a, b)
				return a > b
			end
			local function customHandler(a)
				return -a
			end

			local input = { 20, 50, -20, 30, 10 }
			local output = min(input, customHandler, customComparator)
			expect(output).toEqual(-20)
		end)
	end)

	describe("with default comparator and custom handler", function()
		it("should get minimal element", function()
			local function customHandler(a)
				return -a
			end

			local input = { 20, 50, -20, 30, 10 }
			local output = min(input, customHandler)
			expect(output).toEqual(50)
		end)
	end)

	it("should return nil if table is empty", function()
		local input = {}
		local output = min(input)
		expect(output).toEqual(nil)
	end)
end)
