return function()
	local Dash = require(script.Parent)
	local keyBy = Dash.keyBy

	describe("keyBy", function()
		it("should return an empty table for an empty grouping", function()
			local output = keyBy({}, function(child, index)
				return 5
			end)
			assertSnapshot(output)
		end)

		it("should return the most recent value for aliased keys", function()
			local output = keyBy({1, 2, 3, 4, 5}, function(child, index)
				return index % 2
			end)
			assertSnapshot(output)
		end)

		it("should return a table with a separate entries for unique keys", function()
			local output = keyBy({1, 2, 3, 4, 5}, function(child, key)
				return key
			end)
			assertSnapshot(output)
		end)

		it("should perform assignment for maps and a getKey string", function()
			local output = keyBy({
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
