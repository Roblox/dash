return function()
	local Dash = require(script.Parent)
	local filterPairs = Dash.filterPairs

	describe("filterPairs", function()
		it("should filter an element in a table by key or value", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = filterPairs(input, function(value, key)
				return key == "b" or value == 30
			end)
			assertSnapshot(output, [[{
	b = 20,
	c = 30
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				filterPairs()
			end, [[AssertError: Attempted to call Dash.filterPairs with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				filterPairs({})
			end, [[AssertError: Attempted to call Dash.filterPairs with argument #2 of type "nil" not "function"]])
		end)
	end)
end
