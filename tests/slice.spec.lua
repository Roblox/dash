return function()
	local Dash = require(script.Parent)
	local slice = Dash.slice

	describe("slice", function()
		it("should return a copy of an array with no index arguments", function()
			local output = slice({1, 2, 3, 4, 5})
			assertSnapshot(output, [[{
	1,
	2,
	3,
	4,
	5
}]])
		end)
		it("should return a slice with positive left index", function()
			local output = slice({1, 2, 3, 4, 5}, 2)
			assertSnapshot(output, [[{
	2,
	3,
	4,
	5
}]])
		end)
		it("should return a slice with positive indices", function()
			local output = slice({1, 2, 3, 4, 5}, 2, 4)
			assertSnapshot(output, [[{
	2,
	3,
	4
}]])
		end)
		it("should return a slice with negative left index", function()
			local output = slice({1, 2, 3, 4, 5}, -2)
			assertSnapshot(output, [[{
	3,
	4,
	5
}]])
		end)
		it("should return a slice with negative right index", function()
			local output = slice({1, 2, 3, 4, 5}, 2, -1)
			assertSnapshot(output, [[{
	2,
	3,
	4
}]])
		end)
		it("should return a slice with negative indices", function()
			local output = slice({1, 2, 3, 4, 5}, -3, -1)
			assertSnapshot(output, [[{
	2,
	3,
	4
}]])
		end)
		it("should return a slice with positive left & negative right indices", function()
			local output = slice({1, 2, 3, 4, 5}, 2, -1)
			assertSnapshot(output, [[{
	2,
	3,
	4
}]])
		end)
		it("should return a slice with negative left & positive right indices", function()
			local output = slice({1, 2, 3, 4, 5}, -3, 4)
			assertSnapshot(output, [[{
	2,
	3,
	4
}]])
		end)
		it("should return an empty slice for invalid positive indices", function()
			local output = slice({1, 2, 3, 4, 5}, 100, 1000)
			assertSnapshot(output, [[{}]])
		end)
		it("should return an empty slice for invalid negative indices", function()
			local output = slice({1, 2, 3, 4, 5}, -100, -1000)
			assertSnapshot(output, [[{}]])
		end)
		it("should return an empty slice for swapped indices", function()
			local output = slice({1, 2, 3, 4, 5}, 4, 3)
			assertSnapshot(output, [[{}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				slice()
			end, [[AssertError: Attempted to call Dash.slice with argument #1 of type "nil" not "table"]])
		end)

		it("ensures indices of the correct type", function()
			assertThrows(function()
				slice({}, "wow")
			end, [[AssertError: Attempted to call Dash.slice with argument #2 of type "string" not "number"]])
				assertThrows(function()
					slice({}, 3, true)
				end, [[AssertError: Attempted to call Dash.slice with argument #3 of type "boolean" not "number"]])
		end)
	end)
end
