return function()
	local Dash = require(script.Parent)
	local flat = Dash.flat

	describe("flat", function()
		it("should flatten an array correctly", function()
			local input = {{10, 20}, {30, 40}, {50, {60}}}
			local output = flat(input)
			assertSnapshot(output, [[{
	10,
	20,
	30,
	40,
	50,
	{
		60
	}
}]])
		end)
	end)
end
