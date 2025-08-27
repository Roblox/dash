local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)

local it = JestGlobals.it
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local jest = JestGlobals.jest
local beforeEach = JestGlobals.beforeEach
local afterEach = JestGlobals.afterEach

local Dash = require(Packages.Dash)
local debounce = Dash.debounce

describe("debounce", function()
	beforeEach(function()
		jest.useFakeTimers()
		jest.setEngineFrameTime(1000 / 60)
	end)

	afterEach(function()
		jest.useRealTimers()
	end)

	it("should call the function after the wait time has passed", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn()
		expect(mock).never.toHaveBeenCalled()
		jest.advanceTimersByTime(150)
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
		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should pass the latest arguments to the original function", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn("Hello", "World")
		debouncedFn("Goodbye", "World")

		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledWith("Goodbye", "World")
	end)

	it("should reset the wait timer on each new call", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.1)

		debouncedFn()
		jest.advanceTimersByTime(50)
		expect(mock).toHaveBeenCalledTimes(0)

		-- This call should reset the 0.1s timer
		debouncedFn()
		jest.advanceTimersByTime(80)
		expect(mock).toHaveBeenCalledTimes(0)

		-- Wait for the full 0.1s from the *second* call to elapse
		jest.advanceTimersByTime(30)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should default to trailing with zero delay (next tick)", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0)

		debouncedFn(1, 2, 3)
		expect(mock).never.toHaveBeenCalled()
		-- Next scheduler tick
		jest.runOnlyPendingTimers()
		expect(mock).toHaveBeenCalledTimes(1)
		expect(mock).toHaveBeenCalledWith(1, 2, 3)
	end)

	it("should support leading only (no trailing)", function()
		local mock = jest.fn()
		local debouncedFn = debounce(
			function(...)
				mock(...)
			end,
			0.1,
			{
				leading = true,
				trailing = false,
			}
		)

		debouncedFn("a")
		-- Immediate leading call
		expect(mock).toHaveBeenCalledTimes(1)
		-- No trailing call afterwards
		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should support leading and trailing (immediate + trailing once with latest args)", function()
		local mock = jest.fn()
		local debouncedFn = debounce(
			function(...)
				mock(...)
			end,
			0.1,
			{
				leading = true,
				trailing = true,
			}
		)

		debouncedFn("first")
		-- Leading fires immediately
		expect(mock).toHaveBeenCalledTimes(1)
		debouncedFn("second")
		debouncedFn("third")

		-- After delay, only one trailing call should fire with the latest args
		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(2)
		expect(mock).toHaveBeenLastCalledWith("third")
	end)

	it("should preserve nil arguments in trailing call", function()
		local mock = jest.fn()
		local debouncedFn = debounce(function(...)
			mock(...)
		end, 0.05)

		debouncedFn("a", nil, "c")
		-- Wait for trailing
		jest.advanceTimersByTime(70)
		expect(mock).toHaveBeenCalledTimes(1)
		expect(mock).toHaveBeenCalledWith("a", nil, "c")
	end)
end)
