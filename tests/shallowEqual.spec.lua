local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local shallowEqual = Dash.shallowEqual

describe("shallowEqual", function()
	it("should run correctly for primitive inputs", function()
		expect(shallowEqual("toast", "toast")).toBe(true)
		expect(shallowEqual("toast", "bread")).toBe(false)
		expect(shallowEqual(5, 5)).toBe(true)
		expect(shallowEqual(5, 50)).toBe(false)
		expect(shallowEqual("toast", 5)).toBe(false)
		expect(shallowEqual(5, "5")).toBe(false)
		expect(shallowEqual(5, nil)).toBe(false)
		expect(shallowEqual(nil, nil)).toBe(true)
	end)
	it("should run correctly for one table input", function()
		expect(shallowEqual({}, "toast")).toBe(false)
		expect(shallowEqual("toast", {})).toBe(false)
		expect(shallowEqual({}, nil)).toBe(false)
		expect(shallowEqual(nil, {})).toBe(false)
	end)
	it("should run correctly for arrays", function()
		expect(shallowEqual({}, {})).toBe(true)
		expect(shallowEqual({}, { 1, 2, 3 })).toBe(false)
		expect(shallowEqual({ 1, 2, 3 }, { 1, 2, 3 })).toBe(true)
	end)
	it("should run correctly for maps", function()
		expect(shallowEqual({ x = 3 }, { x = 3 })).toBe(true)
		expect(shallowEqual({ x = 3 }, { x = 3, y = 4 })).toBe(false)
		expect(shallowEqual({ x = 3, y = 4 }, { x = 3, y = 4000 })).toBe(false)
		expect(shallowEqual({ x = 3, y = 4000 }, { x = 3 })).toBe(false)
		local child = { d = 9 }
		expect(shallowEqual({ x = 3, y = child }, { x = 3, y = child })).toBe(true)
		expect(shallowEqual({ x = 3, y = child }, { x = 3, y = { d = 9 } })).toBe(false)
	end)
end)
