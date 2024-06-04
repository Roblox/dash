local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local zip = Dash.zip

describe("zip", function()
	it("should return pairs of the items with the same index from given arrays", function()
		local output = {}
		for item1, item2 in zip({ 1, 2, 3 }, { 4, 5, 6 }) do
			table.insert(output, { item1, item2 })
		end
		expect(output).toEqual({ { 1, 4 }, { 2, 5 }, { 3, 6 } })
	end)

	it("should return elements until the shortest array ends", function()
		local output = {}
		for item1, item2 in zip({ 1, 2, 3, 10, 78 }, { 4, 5, 6 }) do
			table.insert(output, { item1, item2 })
		end
		expect(output).toEqual({ { 1, 4 }, { 2, 5 }, { 3, 6 } })

		local output2 = {}
		for item1, item2 in zip({ 1, 2, 3 }, { 4, 5, 6, 10, 78 }) do
			table.insert(output2, { item1, item2 })
		end
		expect(output2).toEqual({ { 1, 4 }, { 2, 5 }, { 3, 6 } })
	end)
end)
