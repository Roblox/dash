return function()
	local Dash = require(script.Parent)
	local map = Dash.map

	describe("map", function()
		it("should map elements into a new array", function()
			local input = {10, 20, 30, 50}
			local output = map(input, function(value, key)
				return key .. "=" .. value
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				map()
			end, [[AssertError: Attempted to call Dash.map with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				map({})
			end, [[AssertError: Attempted to call Dash.map with argument #2 of type "nil" not "function"]])
		end)

		it("ensures handler does not return nil", function()
			assertThrows(function()
				map({1}, function()
					return nil
				end)
			end, [[AssertError: Returned nil from a Dash.map handler]])
		end)
	end)
end
