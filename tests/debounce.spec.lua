local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)

local it = JestGlobals.it
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local jest = JestGlobals.jest

local debounce = require(Packages.debounce)

describe("debounce", function()
	it("should call the function after the wait time has passed", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn()
		expect(mock).never.toHaveBeenCalled()
		task.wait(0.15)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should only call the function once after multiple rapid calls", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn()
		debouncedFn()
		debouncedFn()

		expect(mock).never.toHaveBeenCalled()
		task.wait(0.15)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should pass the latest arguments to the original function", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn("Hello", "World")
		debouncedFn("Goodbye", "World")

		task.wait(0.15)
		expect(mock).toHaveBeenCalledWith("Goodbye", "World")
	end)

	it("should reset the wait timer on each new call", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn()
		task.wait(0.05)
		expect(mock).toHaveBeenCalledTimes(0)

		-- This call should reset the 0.1s timer
		debouncedFn()
		task.wait(0.08)
		expect(mock).toHaveBeenCalledTimes(0)

		-- Wait for the full 0.1s from the *second* call to elapse
		task.wait(0.03)
		expect(mock).toHaveBeenCalledTimes(1)
	end)
end)
