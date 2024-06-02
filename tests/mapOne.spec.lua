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
			assertSnapshot(output, [["b"]])
		end)

		it("should return any element if the handler is not defined", function()
			local input = {a = 6}
			local output = mapOne(input)
			assertSnapshot(output, [[6]])
		end)
	end)
end
