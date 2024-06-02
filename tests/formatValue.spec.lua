return function()
	local Dash = require(script.Parent)
	local formatValue = Dash.formatValue

	describe("formatValue", function()
		it("should provide a default format for a range of input types", function()
			assertSnapshot(formatValue("Hello world"), [["Hello world"]])
			assertSnapshot(formatValue(255.0), [["255"]])
			assertSnapshot(formatValue(255.3), [["255.300000"]])
		end)
		it("should format a range of input types using displayString", function()
			assertSnapshot(formatValue(255, "s"), [["255"]])
			assertSnapshot(formatValue(255, "06X"), [["0000FF"]])
			assertSnapshot(formatValue({a = 2, b = {2, 3}}, "?"), [["{a = 2, b = {2, 3}}"]])
			assertSnapshot(formatValue({a = 2, b = {2, 3}}, "#?"), [["{
	a = 2,
	b = {
		2,
		3
	}
}"]])
		end)
	end)
end
