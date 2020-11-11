return function()
	local Dash = require(script.Parent)
	local values = Dash.values

	local sort = table.sort

	describe("values", function()
		it("should return an empty table for an empty map", function()
			local output = values({})
			assertSnapshot(output, [[{}]])
		end)

		it("should return a list of the values of an array", function()
			local output = values({10, 20, 30, 40, 50})
			sort(output)
			assertSnapshot(output, [[{
	10,
	20,
	30,
	40,
	50
}]])
		end)

		it("should return a list of the values of a map", function()
			local output = values({a = 10, b = 20, c = 30, d = 40, e = 50})
			sort(output)
			assertSnapshot(output, [[{
	10,
	20,
	30,
	40,
	50
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				values(355)
			end, [[AssertError: Attempted to call Dash.values with argument #1 of type "number" not "table"]])
		end)
	end)
end
