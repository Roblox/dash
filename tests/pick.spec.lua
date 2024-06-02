return function()
	local Dash = require(script.Parent)
	local pick = Dash.pick

	describe("pick", function()
		it("should pick elements in a map by key or value", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = pick(input, function(value, key)
				return key == "b" or value == 30
			end)
			assertSnapshot(output, [[{
	b = 20,
	c = 30
}]])
		end)
	end)
end
