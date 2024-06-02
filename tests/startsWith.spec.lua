return function()
	local Dash = require(script.Parent)
	local startsWith = Dash.startsWith

	describe("startsWith", function()
		it("should correctly test the string ending", function()
			assertSnapshot(startsWith("Fun Roblox Games", "Fun"), [[true]])
			assertSnapshot(startsWith("Card Games", "Fun"), [[false]])
			assertSnapshot(startsWith("Roblox Games", "A string that is longer than the input"), [[false]])
		end)
	end)
end
