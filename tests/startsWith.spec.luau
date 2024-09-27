local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local startsWith = Dash.startsWith

describe("startsWith", function()
	it("should correctly test the string ending", function()
		expect(startsWith("Fun Roblox Games", "Fun")).toBe(true)
		expect(startsWith("Card Games", "Fun")).toBe(false)
		expect(startsWith("Roblox Games", "A string that is longer than the input")).toBe(false)
	end)
end)
