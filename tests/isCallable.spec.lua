return function()
	local Dash = require(script.Parent)
	local isCallable = Dash.isCallable

	describe("isCallable", function()
		it("should return the expected value for a range of inputs", function()
			local callable = {}
			setmetatable(callable, {
				__call = function()
				end
			})
			assertSnapshot(isCallable(26), [[false]])
			assertSnapshot(isCallable(false), [[false]])
			assertSnapshot(isCallable("hoop"), [[false]])
			assertSnapshot(isCallable({}), [[false]])
			assertSnapshot(isCallable(function() end), [[true]])
			assertSnapshot(isCallable(callable), [[true]])
		end)
	end)
end
