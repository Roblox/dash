return function()
	local Dash = require(script.Parent)
	local last = Dash.last

	describe("last", function()
		it("should find the last element if no handler is provided", function()
			local input = {10, 20, 30, 40}
			local output = last(input)
			assertSnapshot(output, [[40]])
		end)

		it("should find an element in a table by index", function()
			local input = {10, 20, 30, 40}
			local output = last(input, function(_value, index)
				return index < 3
			end)
			assertSnapshot(output, [[20]])
		end)

		it("should find the last element in a table by value", function()
			local input = {10, 20, 30, 40}
			local output = last(input, function(value)
				return value < 30
			end)
			assertSnapshot(output, [[20]])
		end)

		it("should not find an element which does not exist", function()
			local input = {10, 20, 30, 40}
			local output = last(input, function(_value, index)
				return index == 10
			end)
			assertSnapshot(output, [[nil]])
		end)
	end)
end
