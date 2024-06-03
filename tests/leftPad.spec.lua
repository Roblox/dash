local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local leftPad = Dash.leftPad

describe("leftPad", function()
	it("should run correctly for a range of inputs", function()
		expect(leftPad("toast", 6)).toEqual(" toast")
		expect(leftPad("2", 2, "0")).toEqual("02")
		expect(leftPad("toast", 10, ":)")).toEqual(":):):toast")
	end)
end)
