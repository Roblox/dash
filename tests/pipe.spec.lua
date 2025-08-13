local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local pipe = Dash.pipe

describe("pipe", function()
	it("should pipe functions from left to right", function()
		local function addOne(n)
			return n + 1
		end

		local function double(n)
			return n * 2
		end

		local addThenDouble = pipe(addOne, double)
		expect(addThenDouble(2)).toEqual(6) -- (2 + 1) * 2 = 6
	end)

	it("should handle multiple arguments for the first function", function()
		local function add(a, b)
			return a + b
		end

		local function double(n)
			return n * 2
		end

		local addThenDouble = pipe(add, double)
		expect(addThenDouble(2, 3)).toEqual(10) -- (2 + 3) * 2 = 10
	end)


	it("should handle functions that return multiple values", function()
		local function returnTwo(n)
			return n, n * 2
		end

		local function add(a, b)
			return a + b
		end

		local pipeline = pipe(returnTwo, add)
		expect(pipeline(3)).toEqual(9) -- 3 + 6 = 9
	end)
end)
