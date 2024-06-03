local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local assign = Dash.assign
local None = Dash.None

describe("assign", function()
	it("should assign to an empty table", function()
		local input = {}
		local output = assign(input, { a = 1 }, { b = 2 })
		expect(output).toEqual({
			a = 1,
			b = 2,
		})
		expect(input).toEqual(output)
	end)

	it("should assign to a table with existing values, overwriting existing keys", function()
		expect(assign({ a = 1 }, { a = 2, b = 3 }, { b = 4 })).toEqual({
			a = 2,
			b = 4,
		})
	end)

	it("should skip nil arguments", function()
		expect(assign({ a = 1, b = 2 }, nil, nil, { c = 3 })).toEqual({
			a = 1,
			b = 2,
			c = 3,
		})
	end)

	it("should skip None arguments", function()
		expect(assign({ a = 1, b = 2 }, None, None, { c = 3 })).toEqual({
			a = 1,
			b = 2,
			c = 3,
		})
	end)

	it("should remove exisintg elements when new value is None", function()
		expect(assign({ a = 1, b = 2 }, { b = None })).toEqual({
			a = 1,
			b = nil,
		})
	end)
end)
