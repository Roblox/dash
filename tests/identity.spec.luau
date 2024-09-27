local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local identity = Dash.identity

describe("identity", function()
	it("should return the input", function()
		local output = {}
		expect(identity(output)).toEqual(output)
		expect(identity(5)).toEqual(5)
		expect(identity(true)).toEqual(true)
		expect(identity("hula")).toEqual("hula")
		expect(identity(nil)).toBeNil()
	end)
end)
