return function()
	local Dash = require(script.Parent)
	local mapFirst = Dash.mapFirst

	describe("mapFirst", function()
		it("should return the first element", function()
			local input = {12, 13, 14, 15, 16}
			local output = mapFirst(input, function(value, key)
				if value > 13 then
					return value * 10
				else
					return nil
				end
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				mapFirst()
			end, [[AssertError: Attempted to call Dash.mapFirst with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				mapFirst({})
			end, [[AssertError: Attempted to call Dash.mapFirst with argument #2 of type "nil" not "function"]])
		end)
	end)
end
