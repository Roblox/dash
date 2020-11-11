return function()
	local Dash = require(script.Parent)
	local splitOn = Dash.splitOn

	describe("splitOn", function()
		it("should return an empty array for an empty string", function()
			local output = splitOn("", "[.:()]")
			assertSnapshot(output)
		end)
		it("should split a string based on a pattern", function()
			local output = splitOn("zombie.Head.Part:Connect()", "[.:()]")
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				splitOn()
			end, [[AssertError: Attempted to call Dash.splitOn with argument #1 of type "nil" not "string"]])
		end)

		it("ensures a handler of the correct type", function()
			assertThrows(function()
				splitOn("test string")
			end, [[AssertError: Attempted to call Dash.splitOn with argument #2 of type "nil" not "string"]])
		end)
	end)
end
