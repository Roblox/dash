return function()
	local Dash = require(script.Parent)
	local findIndex = Dash.findIndex

	describe("findIndex", function()
		it("should find an element in a table by index", function()
			local input = {10, 20, 30, 40}
			local output = findIndex(input, function(index, value)
				return index == 2
			end)
			assertSnapshot(output)
		end)

		it("should find an element in a table by value", function()
			local input = {10, 20, 30, 40}
			local output = findIndex(input, function(index, value)
				return value == 20
			end)
			assertSnapshot(output)
		end)

		it("should not find an element which does not exist", function()
			local input = {10, 20, 30, 40}
			local output = findIndex(input, function(index, value)
				return index == 10
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				findIndex()
			end, [[AssertError: Attempted to call Dash.findIndex with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				findIndex({})
			end, [[AssertError: Attempted to call Dash.findIndex with argument #2 of type "nil" not "function"]])
		end)
	end)
end
