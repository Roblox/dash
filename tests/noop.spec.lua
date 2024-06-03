local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local noop = Dash.noop

describe("noop", function()
	it("should run without error and return nil", function()
		expect(noop()).toBeNil()
	end)
end)
