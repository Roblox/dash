return function()
	local Dash = require(script.Parent)
	local pretty = Dash.pretty

	describe("pretty", function()

		it("should print primitive values", function()
			assert(pretty("stringy") == [["stringy"]])
			assert(pretty(15) == [[15]])
			assert(pretty(true) == [[true]])
			local function myFunction()

			end
			assert(pretty(myFunction) == tostring(myFunction))
		end)

		it("should print a map with string keys", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = pretty(input)
			assert(output == [[{a = 10, b = 20, c = 30, d = 50}]])
		end)

		it("should print an array", function()
			local input = {10, 20, 30, 50}
			local output = pretty(input)
			assert(output == [[{10, 20, 30, 50}]])
		end)
		
	end)
end
