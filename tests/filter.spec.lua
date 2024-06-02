return function()
	local Dash = require(script.Parent)
	local filter = Dash.filter

	local sort = table.sort

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

		it("should filter an element in a table by key or value", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = filter(input, function(value, key)
				return key == "b" or value == 30
			end)
			sort(output)
			assertSnapshot(output, [[{
	20,
	30
}]])
		end)
	end)
end
