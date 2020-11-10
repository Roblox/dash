return function()
	local Dash = require(script.Parent)
	local mapOne = Dash.mapOne

	describe("mapOne", function()
		it("should return an element that the handler does not return nil for", function()
			local input = {a = 5, b = 6, c = 7, d = 8}
			local output = mapOne(input, function(value, key)
				if value == 6 then
					return key
				end
			end)
			assertSnapshot(output)
		end)

		it("should return any element if the handler is not defined", function()
			local input = {a = 6}
			local output = mapOne(input)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				mapOne()
			end, [[AssertError: Attempted to call Dash.mapOne with argument #1 of type "nil" not "table"]])
		end)
	end)
end
