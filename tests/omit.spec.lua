return function()
	local Dash = require(script.Parent)
	local omit = Dash.omit

	describe("omit", function()
		it("should omit entries from a map based on key", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = omit(input, {"a", "b"})
			assertSnapshot(output, [[{
	c = 30,
	d = 50
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				omit()
			end, [[AssertError: Attempted to call Dash.omit with argument #1 of type "nil" not "table"]])
		end)

		it("ensures the keys array has the correct type", function()
			assertThrows(function()
				omit({})
			end, [[AssertError: Attempted to call Dash.omit with argument #2 of type "nil" not "table"]])
		end)
	end)
end
