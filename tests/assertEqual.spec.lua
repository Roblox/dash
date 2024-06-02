local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local assertEqual = Dash.assertEqual

describe("assertEqual", function()
	-- TODO (AleksandrSl 02/06/2024): Check that the old implementation behaved closely
	it("should run correctly", function()
		assertEqual(510, 510)
		expect(function()
			assertEqual("duck", "goose")
		end).toThrow('Left "duck" does not equal right "goose"')
	end)
end)
