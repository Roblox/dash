return function()
	local Dash = require(script.Parent)
	local forEachArgs = Dash.forEachArgs

	local insert = table.insert

	describe("forEachArgs", function()
		it("should iterate through elements of an array", function()
			local output = {}
			local test(...)
				forEachArgs(function(value, key)
					insert(output, key + value)
				end, ...)
			end
			test(1, 2, 3, 4, 5)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				forEachArgs()
			end, [[AssertError: Attempted to call Dash.forEach with argument #1 of type "nil" not "table"]])
		end)
	end)
end
