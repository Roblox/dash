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
	end)
end
