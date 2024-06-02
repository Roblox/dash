return function()
	local Dash = require(script.Parent)
	local reverse = Dash.reverse

	local insert = table.insert

	describe("reverse", function()
		it("should reverse the order of an array without modifying the input", function()
			local input = {10, 20, 30, 40}
			local output = reverse(input)
			assertSnapshot(input, [[{
	10,
	20,
	30,
	40
}]])
			assertSnapshot(output, [[{
	40,
	30,
	20,
	10
}]])
		end)
	end)
end
