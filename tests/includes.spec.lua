return function()
	local Dash = require(script.Parent)
	local includes = Dash.includes

	describe("includes", function()
		it("should return the expected value for arrays", function()
			assertSnapshot(includes({1, 2, 3, 4, 5}, 5), [[true]])
			assertSnapshot(includes({1, 2, 3, 4, 5}, 6), [[false]])
		end)

		it("should return the expected value for maps", function()
			assertSnapshot(includes({a = 1, b = 5, c = 3}, 5), [[true]])
			assertSnapshot(includes({a = 1, b = 5, c = 3}, 6), [[false]])
		end)

		it("should return false for nil", function()
			assertSnapshot(includes({a = nil}, nil), [[false]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				includes()
			end, [[AssertError: Attempted to call Dash.includes with argument #1 of type "nil" not "table"]])
		end)
	end)
end
