return function()
	local Dash = require(script.Parent)
	local endsWith = Dash.endsWith

	describe("endsWith", function()
		it("should correctly test the string ending", function()
			assertSnapshot(endsWith("Roblox Games", "Games"))
			assertSnapshot(endsWith("Roblox Games", "Hard Work"))
			assertSnapshot(endsWith("Roblox Games", "A string that is longer than the input"))
		end)

		it("ensures arguments of correct type", function()
			assertThrows(function()
				endsWith(5)
			end, [[AssertError: Attempted to call Dash.endsWith with argument #1 of type "number" not "string"]])
			assertThrows(function()
				endsWith("test", 4)
			end, [[AssertError: Attempted to call Dash.endsWith with argument #2 of type "number" not "string"]])
		end)


	end)
end
