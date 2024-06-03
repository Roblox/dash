local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local assertEqual = Dash.assertEqual

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("assertEqual", function()
	it("should run correctly", function()
		assertEqual(510, 510)
		expect(function()
			assertEqual("duck", "goose")
		end).toThrowWithMessage('AssertError: Left "duck" does not equal right "goose"')
	end)
end)
