return function()
	local Dash = require(script.Parent)
	local assertEqual = Dash.assertEqual

	describe("assertEqual", function()
		it("should run correctly", function()
			assertEqual(510, 510)
			assertThrows(function()
				assertEqual("duck", "goose")
			end, [[AssertError: Left "duck" does not equal right "goose"]])
		end)

	end)
end
