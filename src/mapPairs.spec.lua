return function()
	local Dash = require(script.Parent)
	local mapPairs = Dash.mapPairs

	describe("mapPairs", function()
		it("should map elements into a new map", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = mapPairs(input, function(value, key)
				return key .. "=" .. value
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				mapPairs()
			end, [[AssertError: Attempted to call Dash.mapPairs with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				mapPairs({})
			end, [[AssertError: Attempted to call Dash.mapPairs with argument #2 of type "nil" not "function"]])
		end)

		it("ensures handler does not return nil", function()
			assertThrows(function()
				mapPairs({1}, function()
					return nil
				end)
			end, [[AssertError: Returned nil from a Dash.mapPairs handler]])
		end)
	end)
end
