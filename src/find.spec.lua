return function()
	local Dash = require(script.Parent)
	local find = Dash.find

	describe("find", function()
		it("should find an element in a table by key", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(key, value)
				return key == "b"
			end)
			assertSnapshot(output)
		end)

		it("should find an element in a table by value", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(key, value)
				return value == 20
			end)
			assertSnapshot(output)
		end)

		it("should not find an element which does not exist", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = find(input, function(key, value)
				return key == "f"
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				find()
			end, [[AssertError: Attempted to call Dash.find with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				find({})
			end, [[AssertError: Attempted to call Dash.find with argument #2 of type "nil" not "function"]])
		end)
	end)
end
