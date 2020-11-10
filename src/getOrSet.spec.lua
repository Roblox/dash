return function()
	local Dash = require(script.Parent)
	local getOrSet = Dash.getOrSet

	describe("getOrSet", function()
		it("should return an existing value", function()
			local throw()
				error("This should not be called")
			end
			assertSnapshot(getOrSet({a = 2}, "a"))
		end)

		it("should set a new value", function()
			local getValue(input, key)
				return input.a + key
			end
			local output = {a = 5}
			assertSnapshot(getOrSet(output, 8))
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				getOrSet()
			end, [[AssertError: Attempted to call Dash.getOrSet with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a key of correct type", function()
			assertThrows(function()
				getOrSet({})
			end, [[AssertError: Attempted to call Dash.getOrSet with a nil key argument]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				getOrSet({}, "key")
			end, [[AssertError: Attempted to call Dash.getOrSet with argument #3 of type "nil" not "function"]])
		end)
	end)
end
