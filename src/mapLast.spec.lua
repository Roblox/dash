return function()
	local Dash = require(script.Parent)
	local mapLast = Dash.mapLast

	describe("mapLast", function()
		it("should return the first element that the handler does not return nil for", function()
			local input = {12, 13, 14, 15, 16}
			local output = mapLast(input, function(value, key)
				if value < 14 then
					return value * 10
				else
					return nil
				end
			end)
			assertSnapshot(output, [[130]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				mapLast()
			end, [[AssertError: Attempted to call Dash.mapLast with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				mapLast({})
			end, [[AssertError: Attempted to call Dash.mapLast with argument #2 of type "nil" not "function"]])
		end)
	end)
end
