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
	end)
end
