local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local get = Dash.get

describe("get", function()
	it("should get direct property values", function()
		local object = { a = 1, b = 2 }
		expect(get(object, { "a" })).toBe(1)
		expect(get(object, { "b" })).toBe(2)
	end)

	it("should get nested property values", function()
		local object = {
			a = {
				b = {
					c = 3,
				},
			},
		}
		expect(get(object, { "a", "b", "c" })).toBe(3)
	end)

	it("should return defaultValue for nil resolved values", function()
		local object = { a = { b = 2 } }
		expect(get(object, { "a", "c" }, 5)).toBe(5)
		expect(get(object, { "x", "y", "z" }, "default")).toBe("default")
	end)

	it("should return nil for missing paths when no defaultValue is provided", function()
		local object = { a = { b = 2 } }
		expect(get(object, { "a", "c" })).toBe(nil)
		expect(get(object, { "x", "y", "z" })).toBe(nil)
	end)

	it("should handle array indexing", function()
		local object = {
			items = {
				{ name = "first" },
				{ name = "second" },
			},
		}
		expect(get(object, { "items", 1, "name" })).toBe("first")
	end)

	it("should handle nil input object", function()
		expect(get(nil, { "a", "b", "c" }, "default")).toBe("default")
		expect(get(nil, { "a", "b", "c" })).toBe(nil)
	end)

	it("should handle non-table values in path", function()
		local object = {
			a = {
				b = 1,
			},
		}
		expect(get(object, { "a", "b", "c" }, "default")).toBe("default")
	end)

	it("should handle complex nested structures", function()
		local object = {
			users = {
				{
					id = 1,
					profile = {
						name = "John",
						settings = {
							theme = "dark",
						},
					},
				},
			},
		}
		expect(get(object, { "users", 1, "profile", "settings", "theme" })).toBe("dark")
	end)

	it("should handle numeric paths", function()
		local object = {
			test = {
				["test.test"] = {
					[0] = "value",
				},
			},
		}
		expect(get(object, { "test", "test.test", 0 })).toBe("value")
	end)
end)
