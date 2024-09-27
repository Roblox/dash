local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local endsWith = Dash.endsWith

describe("endsWith", function()
	it("should correctly test the string ending", function()
		expect(endsWith("Roblox Games", "Games")).toEqual(true)
		expect(endsWith("Roblox Games", "Hard Work")).toEqual(false)
		expect(endsWith("Roblox Games", "A string that is longer than the input")).toEqual(false)
	end)
end)
