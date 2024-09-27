local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local rightPad = Dash.rightPad

describe("rightPad", function()
	it("should run correctly for a range of inputs", function()
		expect(rightPad("toast", 6)).toEqual("toast ")
		expect(rightPad("2", 2, "!")).toEqual("2!")
		expect(rightPad("toast", 10, ":)")).toEqual("toast:):):")
	end)
end)
