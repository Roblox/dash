local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local join = Dash.join
local None = Dash.None

describe("join", function()
	it("should join a tables together", function()
		expect(join({ c = 4 }, { a = 1 }, { b = 2, c = None })).toEqual({
			a = 1,
			b = 2,
		})
	end)

	it("should skip nil arguments", function()
		expect(join({ a = 1, b = 2 }, nil, nil, { c = 3 })).toEqual({
			a = 1,
			b = 2,
			c = 3,
		})
	end)

	it("should skip None arguments", function()
		expect(join({ a = 1, b = 2 }, None, None, { c = 3 })).toEqual({
			a = 1,
			b = 2,
			c = 3,
		})
	end)

	it("should not mutate the original input", function()
		local input = { a = 1, b = 2 }
		expect(join(input, { b = 4 }, { c = 3 })).toEqual({
			a = 1,
			b = 4,
			c = 3,
		})
		expect(input).toEqual({
			a = 1,
			b = 2,
		})
	end)
end)
