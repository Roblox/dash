return function()
	local Dash = require(script.Parent)
	local collectArray = Dash.collectArray

	describe("collectArray", function()
		it("should collect elements from a map into a new array", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collectArray(input, function(key, value)
				return value .. "=" .. key
			end)
			sort(output)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				collectArray()
			end, [[AssertError: Attempted to call Dash.collectArray with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				collectArray({})
			end, [[AssertError: Attempted to call Dash.collectArray with argument #2 of type "nil" not "function"]])
		end)
	end)
end
