local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local splitOn = Dash.splitOn
describe("splitOn", function()
	it("should return a array with a single element for an empty string", function()
		local output = splitOn("", "[.:()]")
		expect(output).toEqual({ "" })
	end)
	it("should split a string based on a pattern", function()
		local output = splitOn("zombie.Head.Part:Connect()", "[.:()]")
		expect(output).toEqual({ "zombie", "Head", "Part", "Connect", "", "" })
	end)
end)
