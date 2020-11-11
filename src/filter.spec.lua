return function()
	local Dash = require(script.Parent)
	local filter = Dash.filter

	describe("filter", function()
		it("should filter elements in an array", function()
			local input = {1, 2, 3, 4}
			local output = filter(input, function(index, value)
				return index == 2 or value == 3
			end)
			assertSnapshot(output, [[{
	2,
	3
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				filter()
			end, [[AssertError: Attempted to call Dash.filter with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				filter({})
			end, [[AssertError: Attempted to call Dash.filter with argument #2 of type "nil" not "function"]])
		end)
	end)
end
