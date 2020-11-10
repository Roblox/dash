return function()
	local Dash = require(script.Parent)
	local isLowercase = Dash.isLowercase

	describe("isLowercase", function()
		it("should return the expected value for a range of inputs", function()
			local callable = {}
			setmetatable(callable, {
				__call = function()
				end
			})
			assertSnapshot(isLowercase("hello"))
			assertSnapshot(isLowercase("Hello"))
			assertSnapshot(isLowercase("êcho"))
			assertSnapshot(isLowercase("Êcho"))
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				isLowercase(58)
			end, [[AssertError: Attempted to call Dash.isLowercase with argument #1 of type "number" not "string"]])
		end)

		it("ensures input is not an empty string", function()
			assertThrows(function()
				isLowercase("")
			end, [[AssertError: Attempted to call Dash.isLowercase with an empty string]])
		end)
	end)
end
