return function()
	local Dash = require(script.Parent)
	local some = Dash.some

	describe("some", function()
		it("should return true if an element matches", function()
			local input = {a = 5, b = 6, c = 7, d = 8}
			local output = some(input, function(value, key)
				return key == "c" or value == 3000
			end)
			assertSnapshot(output, [[true]])
		end)

		it("should return false if no element matches", function()
			local input = {a = 5, b = 6, c = 7, d = 8}
			local output = some(input, function(value, key)
				return key == "No such key"
			end)
			assertSnapshot(output, [[false]])
		end)
	end)
end
