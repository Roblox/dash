local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local mapOne = Dash.mapOne

describe("mapOne", function()
	it("should return an element that the handler does not return nil for", function()
		local input = { a = 5, b = 6, c = 7, d = 8 }
		local output = mapOne(input, function(value, key)
			if value == 6 then
				return key
			else
				return nil
			end
		end)
		expect(output).toEqual("b")
	end)

	it("should return any element if the handler is not defined", function()
		local input = { a = 6 }
		local output = mapOne(input)
		expect(output).toEqual(6)
	end)
end)
