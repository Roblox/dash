return function()
	local Dash = require(script.Parent)
	local copy = Dash.copy
	local pretty = Dash.pretty

	describe("copy", function()
		it("should make a shallow copy of a table", function()
			local input = {a = 10, b = 20, c = 30, reference = {50}}
			local output = copy(input)
			assertSnapshot(input == output, [[false]])
			assertSnapshot(pretty(input) == pretty(output), [[true]])
			assertSnapshot(input.reference == output.reference, [[true]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				copy()
			end, [[AssertError: Attempted to call Dash.copy with argument #1 of type "nil" not "table"]])
		end)

	end)
end
