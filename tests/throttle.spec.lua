local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)

local it = JestGlobals.it
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local jest = JestGlobals.jest
local beforeEach = JestGlobals.beforeEach
local afterEach = JestGlobals.afterEach

local Dash = require(Packages.Dash)
local throttle = Dash.throttle

describe("throttle", function()
	beforeEach(function()
		jest.useFakeTimers()
		jest.setEngineFrameTime(1000 / 60)
	end)

	afterEach(function()
		jest.useRealTimers()
	end)

	it("should call the function immediately on first invocation", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should not call the function again if called within the wait period", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.2)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		throttledFn()
		throttledFn()
		throttledFn()
		throttledFn()
		throttledFn()
		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should call the function again after the wait period has elapsed", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		jest.advanceTimersByTime(150)
		throttledFn()
		expect(mock).toHaveBeenCalledTimes(2)
	end)

	it("should call the function with the latest arguments after the wait period", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.1)

		throttledFn("First", "Call")
		expect(mock).toHaveBeenCalledWith("First", "Call")

		throttledFn("Ignored", "Call")
		throttledFn("Last", "Call")

		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledWith("Last", "Call")
		expect(mock).toHaveBeenCalledTimes(2)
	end)

	it("should schedule only one delayed call even with multiple invocations", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		throttledFn()
		throttledFn()
		throttledFn()

		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(2)
	end)

	it("should reset the throttle after the wait period", function()
		local mock = jest.fn()
		local throttledFn = throttle(mock, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		jest.advanceTimersByTime(150)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(2)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(2)
	end)

	it("should default to leading and trailing with zero delay", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0)

		-- With delay=0 and leading=true, this fires immediately on each call
		throttledFn(1)
		expect(mock).toHaveBeenCalledTimes(1)
		throttledFn(2)
		throttledFn(3)
		expect(mock).toHaveBeenCalledTimes(3)
	end)

	it("should support trailing only (no immediate call)", function()
		local mock = jest.fn()
		local throttledFn = throttle(
			function(...)
				mock(...)
			end,
			0.1,
			{
				leading = false,
				trailing = true,
			}
		)

		throttledFn("a")
		expect(mock).toHaveBeenCalledTimes(0)
		throttledFn("b")
		throttledFn("c")
		-- After the window, only one call with latest args
		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(1)
		expect(mock).toHaveBeenLastCalledWith("c")
	end)

	it("should support leading only (no trailing)", function()
		local mock = jest.fn()
		local throttledFn = throttle(
			function(...)
				mock(...)
			end,
			0.1,
			{
				leading = true,
				trailing = false,
			}
		)

		throttledFn("x")
		expect(mock).toHaveBeenCalledTimes(1)
		-- Burst within the window should not schedule trailing
		throttledFn("y")
		throttledFn("z")
		jest.advanceTimersByTime(150)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should preserve nil arguments when trailing fires", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.05)

		throttledFn("a", nil, "c")
		-- Ensure trailing fires
		jest.advanceTimersByTime(70)
		expect(mock).toHaveBeenCalledTimes(1)
		expect(mock).toHaveBeenCalledWith("a", nil, "c")
	end)
end)
