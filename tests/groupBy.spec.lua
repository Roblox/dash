return function()
	local Dash = require(script.Parent)
	local groupBy = Dash.groupBy

	describe("groupBy", function()
		it("should return an empty table for an empty grouping", function()
			local output = groupBy({}, function(child, key)
				return 5
			end)
			assertSnapshot(output, [[{}]])
		end)

		it("should return a table with a single group for aliased keys", function()
			local output = groupBy({1, 2, 3, 4, 5}, function(child, key)
				return 5
			end)
			assertSnapshot(output, [[{
	5 = {
		1,
		2,
		3,
		4,
		5
	}
}]])
		end)

		it("should return a table with a separate groups for unique keys", function()
			local output = groupBy({1, 2, 3, 4, 5}, function(child, key)
				return key
			end)
			assertSnapshot(output, [[{
	{
		1
	},
	{
		2
	},
	{
		3
	},
	{
		4
	},
	{
		5
	}
}]])
		end)

		it("should allow groups of mixed sizes produced from combining handler arguments", function()
			local output = groupBy({5, 4, 3, 4, 5}, function(child, key)
				return child + key
			end)
			assertSnapshot(output, [[{
	6 = {
		5,
		4,
		3
	},
	8 = {
		4
	},
	10 = {
		5
	}
}]])
		end)

		it("should perform grouping for maps and a getKey string", function()
			local output = groupBy({
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
		{
			color = "blue",
			name = "bike"
		}
	},
	red = {
		{
			color = "red",
			name = "car"
		}
	},
	white = {
		{
			color = "white",
			name = "van"
		}
	}
}]])
		end)
	end)
end
