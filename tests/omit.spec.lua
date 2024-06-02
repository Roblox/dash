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
	end)
end
