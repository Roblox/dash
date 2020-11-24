return function()
	local Dash = require(script.Parent)
	local startsWith = Dash.startsWith

	describe("startsWith", function()
		it("should correctly test the string ending", function()
			assertSnapshot(startsWith("Fun Roblox Games", "Fun"), [[true]])
			assertSnapshot(startsWith("Card Games", "Fun"), [[false]])
			assertSnapshot(startsWith("Roblox Games", "A string that is longer than the input"), [[false]])
		end)

		it("ensures arguments of correct type", function()
			assertThrows(function()
				startsWith(5)
			end, [[AssertError: Attempted to call Dash.startsWith with argument #1 of type "number" not "string"]])
			assertThrows(function()
				startsWith("test", 4)
			end, [[AssertError: Attempted to call Dash.startsWith with argument #2 of type "number" not "string"]])
		end)

	end)
end
