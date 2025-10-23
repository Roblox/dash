local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local union = Dash.union
local None = Dash.None

describe("union", function()
	it("should return a new table with the contents of two tables", function()
		local table1 = { a = 1, b = 2 }
		local table2 = { c = 3, d = 4 }
		expect(union(table1, table2)).toEqual({ a = 1, b = 2, c = 3, d = 4 })
	end)

	it("should overwrite existing keys in the first table with values from the second", function()
		local table1 = { a = 1, b = 2 }
		local table2 = { b = 3, c = 4 }
		expect(union(table1, table2)).toEqual({ a = 1, b = 3, c = 4 })
	end)

	it("should remove keys from the first table if the value in the second is None", function()
		local table1 = { a = 1, b = 2 }
		local table2 = { b = None, c = 3 }
		expect(union(table1, table2)).toEqual({ a = 1, c = 3 })
	end)

	it("should not modify the original tables", function()
		local table1 = { a = 1, b = 2 }
		local table1Original = { a = 1, b = 2 }
		local table2 = { b = 3, c = 4 }
		local table2Original = { b = 3, c = 4 }
		union(table1, table2)
		expect(table1).toEqual(table1Original)
		expect(table2).toEqual(table2Original)
	end)

	it("should handle an empty table as the first argument", function()
		local table1 = {}
		local table2 = { a = 1, b = 2 }
		expect(union(table1, table2)).toEqual({ a = 1, b = 2 })
	end)

	it("should handle an empty table as the second argument", function()
		local table1 = { a = 1, b = 2 }
		local table2 = {}
		expect(union(table1, table2)).toEqual({ a = 1, b = 2 })
	end)

	it("should handle two empty tables", function()
		expect(union({}, {})).toEqual({})
	end)
end)
