local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)

local it = JestGlobals.it
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local jest = JestGlobals.jest

local Dash = require(Packages.Dash)
local throttle = Dash.throttle

describe("throttle", function()
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
		task.delay(0.1, throttledFn)
		task.delay(0.1, throttledFn)
		task.delay(0.1, throttledFn)
		expect(mock).toHaveBeenCalledTimes(1)
	end)

	it("should call the function again after the wait period has elapsed", function()
		local mock = jest.fn()
		local throttledFn = throttle(function(...)
			mock(...)
		end, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		task.wait(0.15)
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

		task.wait(0.15)
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

		task.wait(0.15)
		expect(mock).toHaveBeenCalledTimes(2)
	end)

	it("should reset the throttle after the wait period", function()
		local mock = jest.fn()
		local throttledFn = throttle(mock, 0.1)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(1)

		task.wait(0.15)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(2)

		throttledFn()
		expect(mock).toHaveBeenCalledTimes(2)
	end)
end)
