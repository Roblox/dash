return function()
	local Dash = require(script.Parent)
	local reduce = Dash.reduce

	local insert = table.insert

	describe("reduce", function()
		it("should reduce entries from an array using the handler and value", function()
			local output = reduce({10, 20, 30, 40}, function(a, b)
				return a + b
			end, 0)
			assertSnapshot(output, [[100]])
		end)

		it("should reduce entries from an array using the handler and key", function()
			local output = reduce({10, 20, 30, 40}, function(acc, current, key)
				return acc .. key .. ","
			end, "")
			assertSnapshot(output, [["1,2,3,4,"]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				reduce()
			end, [[AssertError: Attempted to call Dash.reduce with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of the correct type", function()
			assertThrows(function()
				reduce({})
			end, [[AssertError: Attempted to call Dash.reduce with argument #2 of type "nil" not "function"]])
		end)
	end)
end
