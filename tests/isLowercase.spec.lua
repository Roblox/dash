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
			assertSnapshot(isLowercase("hello"), [[true]])
			assertSnapshot(isLowercase("Hello"), [[false]])
			-- Unfortunately not supported in the current version of Lua
			-- assertSnapshot(isLowercase("êcho"), [[true]])
			-- assertSnapshot(isLowercase("Êcho"), [[false]])
		end)

		it("ensures input is not an empty string", function()
			assertThrows(function()
				isLowercase("")
			end, [[AssertError: Attempted to call Dash.isLowercase with an empty string]])
		end)
	end)
end
