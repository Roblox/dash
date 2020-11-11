return function()
	local Dash = require(script.Parent)
	local formatValue = Dash.formatValue

	describe("formatValue", function()
		it("should provide a default format for a range of input types", function()
			assertSnapshot(formatValue("Hello world"))
			assertSnapshot(formatValue(255.0))
			assertSnapshot(formatValue(255.3))
		end)
		it("should format a range of input types using displayString", function()
			assertSnapshot(formatValue(255, "s"))
			assertSnapshot(formatValue(255, "06X"))
			assertSnapshot(formatValue({a = 2, b = {2, 3}}, "?"))
			assertSnapshot(formatValue({a = 2, b = {2, 3}}, "#?"))
		end)

		it("ensures a displayString of correct type", function()
			assertThrows(function()
				formatValue({}, 309)
			end, [[AssertError: Attempted to call Dash.formatValue with argument #2 of type "number" not "string"]])
		end)
	end)
end
