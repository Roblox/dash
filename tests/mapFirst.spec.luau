local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local mapFirst = Dash.mapFirst

describe("mapFirst", function()
	it("should return the first element", function()
		local input = { 12, 13, 14, 15, 16 }
		local output = mapFirst(input, function(value, _)
			if value > 13 then
				return value * 10
			else
				return nil
			end
		end)
		expect(output).toEqual(140)
	end)
end)
