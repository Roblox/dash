return function()
	local Dash = require(script.Parent)
	local reverse = Dash.reverse

	local insert = table.insert

	describe("reverse", function()
		it("should reverse the order of an array without modifying the input", function()
			local input = {10, 20, 30, 40}
			local output = reverse(input)
			assertSnapshot(input)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				reverse()
			end, [[AssertError: Attempted to call Dash.reverse with argument #1 of type "nil" not "table"]])
		end)
	end)
end
