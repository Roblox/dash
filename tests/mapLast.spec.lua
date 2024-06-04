local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local mapLast = Dash.mapLast

describe("mapLast", function()
	it("should return the first element that the handler does not return nil for", function()
		local input = { 12, 13, 14, 15, 16 }
		local output = mapLast(input, function(value, _)
			if value < 14 then
				return value * 10
			else
				return nil
			end
		end)
		expect(output).toEqual(130)
	end)
end)
