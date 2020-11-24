return function()
	local Dash = require(script.Parent)
	local map = Dash.map

	describe("map", function()
		it("should map elements into a new array", function()
			local input = {10, 20, 30, 50}
			local output = map(input, function(value, key)
				return key .. "=" .. value
			end)
			assertSnapshot(output, [[{
	"1=10",
	"2=20",
	"3=30",
	"4=50"
}]])
		end)

it("should map elements into a new map", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = map(input, function(value, key)
				return key .. "=" .. value
			end)
			assertSnapshot(output, [[{
	a = "a=10",
	b = "b=20",
	c = "c=30",
	d = "d=50"
}]])

		end)
		it("ensures an input of the correct type", function()
			assertThrows(function()
				map()
			end, [[AssertError: Attempted to call Dash.map with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				map({})
			end, [[AssertError: Attempted to call Dash.map with argument #2 of type "nil" not "function"]])
		end)

		it("ensures handler does not return nil", function()
			assertThrows(function()
				map({1}, function()
					return nil
				end)
			end, [[AssertError: Returned nil from a Dash.map handler]])
		end)
	end)
end
