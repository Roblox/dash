return function()
	local Dash = require(script.Parent)
	local collect = Dash.collect

	describe("collectArray", function()
		it("should collect elements from a map into a new array", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collect(input, function(key, value)
				return value .. "=" .. key
			end)
			sort(output)
			assertSnapshot(output)
		end)

		it("ensures an input of correct type", function()
			assertThrows(function()
				collect()
			end, [[AssertError: Attempted to call Dash.collect with argument #1 of type "nil" not "table"]])
		end)
	end)
end
