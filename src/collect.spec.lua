return function()
	local Dash = require(script.Parent)
	local collect = Dash.collect

	describe("collect", function()
		it("should collect elements of an array", function()
			local input = {10, 20, 30, 50}
			local output = collect(input, function(key, value)
				return value, key
			end)
			assertSnapshot(output, [[{
	10 = 1,
	20 = 2,
	30 = 3,
	50 = 4
}]])
		end)

		it("should collect elements of a map", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collect(input, function(key, value)
				return value + 1, key .. "!"
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				collect()
			end, [[AssertError: Attempted to call Dash.collect with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				collect({})
			end, [[AssertError: Attempted to call Dash.collect with argument #2 of type "nil" not "function"]])
		end)
	end)
end
