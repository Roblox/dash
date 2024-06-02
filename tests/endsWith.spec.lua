return function()
	local Dash = require(script.Parent)
	local endsWith = Dash.endsWith

	describe("endsWith", function()
		it("should correctly test the string ending", function()
			assertSnapshot(endsWith("Roblox Games", "Games"), [[true]])
			assertSnapshot(endsWith("Roblox Games", "Hard Work"), [[false]])
			assertSnapshot(endsWith("Roblox Games", "A string that is longer than the input"), [[false]])
		end)

	end)
end
