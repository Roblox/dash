local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local memoize = Dash.memoize

describe("memoize", function()
	it("should memoize function results", function()
		local callCount = 0
		local function add(a: number, b: number)
			callCount = callCount + 1
			return a + b
		end

		local memoizedAdd = memoize(add)

		-- First call should compute
		expect(memoizedAdd(1, 2)).toEqual(3)
		expect(callCount).toEqual(1)

		-- Second call should use cache
		expect(memoizedAdd(1, 2)).toEqual(3)
		expect(callCount).toEqual(1)

		-- Different arguments should compute
		expect(memoizedAdd(2, 3)).toEqual(5)
		expect(callCount).toEqual(2)
	end)

	it("should work with custom resolver", function()
		local callCount = 0
		local function multiply(a: number, b: number)
			callCount = callCount + 1
			return a * b
		end

		local memoizedMultiply = memoize(multiply, function(a, b)
			return string.format("%d_%d", a, b)
		end)

		-- First call should compute
		expect(memoizedMultiply(2, 3)).toEqual(6)
		expect(callCount).toEqual(1)

		-- Second call should use cache
		expect(memoizedMultiply(2, 3)).toEqual(6)
		expect(callCount).toEqual(1)

		-- Different arguments should compute
		expect(memoizedMultiply(3, 4)).toEqual(12)
		expect(callCount).toEqual(2)
	end)

	it("should handle nil values in arguments", function()
		local callCount = 0
		local function processNil(value)
			callCount = callCount + 1
			return value == nil and "nil" or tostring(value)
		end

		local memoizedProcess = memoize(processNil)

		-- First call should compute
		expect(memoizedProcess(nil)).toEqual("nil")
		expect(callCount).toEqual(1)

		-- Second call should use cache
		expect(memoizedProcess(nil)).toEqual("nil")
		expect(callCount).toEqual(1)
	end)
end)
