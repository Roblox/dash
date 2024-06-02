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
			assertSnapshot(output, [[140]])
		end)
	end)
end
