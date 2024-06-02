return function()
	local Dash = require(script.Parent)
	local find = Dash.find

	describe("find", function()

		it("should find the first element in an array by index", function()
			local input = {10, 20, 30, 40}
			local output = find(input, function(_value, index)
				return index > 2
			end)
			assertSnapshot(output, [[30]])
		end)

		it("should find the first element in an array by value", function()
			local input = {10, 20, 30, 40}
			local output = find(input, function(value)
				return value > 20
			end)
			assertSnapshot(output, [[30]])
		end)

		it("should find an element in a table by key", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(_value, key)
				return key == "b"
			end)
			assertSnapshot(output, [[20]])
		end)

		it("should find an element in a table by value", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(value)
				return value == 20
			end)
			assertSnapshot(output, [[20]])
		end)

		it("should not find an element which does not exist", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(_value, key)
				return key == "f"
			end)
			assertSnapshot(output, [[nil]])
		end)
	end)
end
