return function()
	local Dash = require(script.Parent)
	local forEachPairs = Dash.forEachPairs

	local insert = table.insert

	describe("forEachPairs", function()
		it("should iterate through elements of an array", function()
			local output = {}
			forEachPairs({a = 1, b = 2, c = 3}, function(value, key)
				insert(output, key .. "=" .. value)
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				forEachPairs()
			end, [[AssertError: Attempted to call Dash.forEachPairs with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				forEachPairs({})
			end, [[AssertError: Attempted to call Dash.forEachPairs with argument #2 of type "nil" not "function"]])
		end)
	end)
end
