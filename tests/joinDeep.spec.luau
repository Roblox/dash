local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local joinDeep = Dash.joinDeep
local None = Dash.None

describe("joinDeep", function()
	it("should join two flat tables", function()
		expect(joinDeep({ a = 1, c = 4 }, { a = 3, b = 2 })).toEqual({
			a = 3,
			b = 2,
			c = 4,
		})
	end)

	it("should deeply join nested tables", function()
		local source = {
			name = "car",
			lights = {
				front = 2,
				back = 2,
				indicators = {
					color = "orange",
				},
				brake = {
					color = "red",
				},
			},
			tyres = 4,
		}
		local delta = {
			name = "bike",
			lights = {
				front = 3,
				indicators = {
					rate = 20,
				},
			},
			tyres = None,
		}
		expect(joinDeep(source, delta)).toEqual({
			lights = {
				back = 2,
				brake = {
					color = "red",
				},
				front = 3,
				indicators = {
					color = "orange",
					rate = 20,
				},
			},
			name = "bike",
		})
	end)

	it("should not mutate the original input", function()
		local input = { a = 1, b = 2 }
		expect(joinDeep(input, { a = 3, b = 2 })).toEqual({
			a = 3,
			b = 2,
		})
		expect(input).toEqual({
			a = 1,
			b = 2,
		})
	end)

	it("should not clone deep tables that don't change", function()
		local source = {
			name = "car",
			lights = {
				front = 2,
				back = 2,
				indicators = {
					color = "orange",
				},
				brake = {
					color = "red",
				},
			},
		}
		local delta = {
			name = "bike",
			lights = {
				front = 3,
				indicators = {
					rate = 20,
				},
			},
			tyres = None,
		}
		local result = joinDeep(source, delta)
		expect(result.lights.brake == source.lights.brake).toBe(true)
	end)
end)
