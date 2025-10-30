local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local mapNotNil = Dash.mapNotNil

describe("mapNotNil", function()
	it("should map elements into a new array", function()
		local input = { 10, 20, 30, 50 }
		local output = mapNotNil(input, function(value, key)
			return key .. "=" .. value
		end)
		expect(output).toEqual({
			"1=10",
			"2=20",
			"3=30",
			"4=50",
		})
	end)

	it("should map elements into a new map", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = mapNotNil(input, function(value: number, key: string)
			return key .. "=" .. value
		end)
		expect(output).toEqual({
			a = "a=10",
			b = "b=20",
			c = "c=30",
			d = "d=50",
		})
	end)

	it("should remove nil elements when creating a new map", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = mapNotNil(input, function(value: number, key: string)
			if key == "c" then
				return nil
			end
			return key .. "=" .. value
		end)
		expect(output).toEqual({
			a = "a=10",
			b = "b=20",
			d = "d=50",
		})
	end)
end)
