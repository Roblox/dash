return function()
	local Dash = require(script.Parent)
	local some = Dash.some

	describe("some", function()
		it("should return true if an element matches", function()
			local input = {a = 5, b = 6, c = 7, d = 8}
			local output = some(input, function(value, key)
				return key == "c" or value == 3000
			end)
			assertSnapshot(output)
		end)

		it("should return false if no element matches", function()
			local input = {a = 5, b = 6, c = 7, d = 8}
			local output = some(input, function(value, key)
				return key == "No such key"	
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				some()
			end, [[AssertError: Attempted to call Dash.some with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of the correct type", function()
			assertThrows(function()
				some({})
			end, [[AssertError: Attempted to call Dash.some with argument #2 of type "nil" not "function"]])
		end)
	end)
end
