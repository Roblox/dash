return function()
	local Dash = require(script.Parent)
	local flat = Dash.flat

	describe("flat", function()
		it("should flatten an array correctly", function()
			local input = {{10, 20}, {30, 40}, {50, {60}}}
			local output = flat(input)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				findIndex()
			end, [[AssertError: Attempted to call Dash.flat with argument #1 of type "nil" not "table"]])
		end)
	end)
end
