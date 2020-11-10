return function()
	local Dash = require(script.Parent)
	local groupBy = Dash.groupBy

	describe("groupBy", function()
		it("should return an empty table for an empty grouping", function()
			local output = groupBy({}, function(child, key)
				return 5
			end)
			assertSnapshot(output)
		end)

		it("should return a table with a single group for aliased keys", function()
			local output = groupBy({1, 2, 3, 4, 5}, function(child, key)
				return 5
			end)
			assertSnapshot(output)
		end)

		it("should return a table with a separate groups for unique keys", function()
			local output = groupBy({1, 2, 3, 4, 5}, function(child, key)
				return key
			end)
			assertSnapshot(output)
		end)

		it("should allow groups of mixed sizes produced from combining handler arguments", function()
			local output = groupBy({5, 4, 3, 4, 5}, function(child, key)
				return child + key
			end)
			assertSnapshot(output)
		end)

		it("should perform grouping for maps and a getKey string", function()
			local output = groupBy({
				bike = {
					name = "blue"
				},
				car = {
					name = "red"
				},
				van = {
					color = "white"
				}
			}, "color")
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				groupBy()
			end, [[AssertError: Attempted to call Dash.groupBy with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a key of correct type", function()
			assertThrows(function()
				groupBy({})
			end, [[AssertError: Attempted to call Dash.groupBy with a nil getKey argument]])
		end)
	end)
end
