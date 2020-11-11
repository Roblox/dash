return function()
	local Dash = require(script.Parent)
	local keyBy = Dash.keyBy

	describe("keyBy", function()
		it("should return an empty table for an empty grouping", function()
			local output = keyBy({}, function(child, index)
				return 5
			end)
			assertSnapshot(output, [[{}]])
		end)

		it("should return the most recent value for aliased keys", function()
			local output = keyBy({1, 2, 3, 4, 5}, function(child, index)
				return index % 2
			end)
			assertSnapshot(output, [[{
	5,
	0 = 4
}]])
		end)

		it("should return a table with a separate entries for unique keys", function()
			local output = keyBy({1, 2, 3, 4, 5}, function(child, key)
				return key
			end)
			assertSnapshot(output, [[{
	1,
	2,
	3,
	4,
	5
}]])
		end)

		it("should perform assignment for maps and a getKey string", function()
			local output = keyBy({
				bike = {
					name = "bike",
					color = "blue"
				},
				car = {
					name = "car",
					color = "red"
				},
				van = {
					name = "van",
					color = "white"
				},
				ghost = {
					name = "ghost"
				}
			}, "color")
			assertSnapshot(output, [[{
	blue = {
		color = "blue",
		name = "bike"
	},
	red = {
		color = "red",
		name = "car"
	},
	white = {
		color = "white",
		name = "van"
	}
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				keyBy()
			end, [[AssertError: Attempted to call Dash.keyBy with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a key of correct type", function()
			assertThrows(function()
				keyBy({})
			end, [[AssertError: Attempted to call Dash.keyBy with a nil getKey argument]])
		end)
	end)
end
