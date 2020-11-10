return function()
	local Dash = require(script.Parent)
	local collectSet = Dash.collectSet

	describe("collectSet", function()
		it("should collect elements from a map into a new set using the default handler", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collectSet(input)
			assertSnapshot(output)
		end)

		it("should collect elements from a map into a new set", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collect(input, function(key, value)
				return value .. "=" .. key
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				collect()
			end, [[AssertError: Attempted to call Dash.collectSet with argument #1 of type "nil" not "table"]])
		end)

	end)
end
