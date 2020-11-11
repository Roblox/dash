return function()
	local Dash = require(script.Parent)
	local keys = Dash.keys

	local sort = table.sort

	describe("keys", function()
		it("should return an empty table for an empty map", function()
			local output = keys({})
			assertSnapshot(output)
		end)

		it("should return a list of the keys of an array", function()
			local output = keys({10, 20, 30, 40, 50})
			sort(output)
			assertSnapshot(output)
		end)

		it("should return a list of the keys of a map", function()
			local output = keys({a = 10, b = 20, c = 30, d = 40, e = 50})
			sort(output)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				keys(355)
			end, [[AssertError: Attempted to call Dash.keys with argument #1 of type "number" not "table"]])
		end)
	end)
end
