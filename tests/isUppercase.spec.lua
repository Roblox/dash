return function()
	local Dash = require(script.Parent)
	local isUppercase = Dash.isUppercase

	describe("isUppercase", function()
		it("should return the expected value for a range of inputs", function()
			local callable = {}
			setmetatable(callable, {
				__call = function()
				end
			})
			assertSnapshot(isUppercase("hello"), [[false]])
			assertSnapshot(isUppercase("Hello"), [[true]])
			-- Unfortunately not supported in the current version of Lua
			-- assertSnapshot(isUppercase("êcho"), [[false]])
			-- assertSnapshot(isUppercase("Êcho"), [[true]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				isUppercase(58)
			end, [[AssertError: Attempted to call Dash.isUppercase with argument #1 of type "number" not "string"]])
		end)

		it("ensures input is not an empty string", function()
			assertThrows(function()
				isUppercase("")
			end, [[AssertError: Attempted to call Dash.isUppercase with an empty string]])
		end)
	end)
end
