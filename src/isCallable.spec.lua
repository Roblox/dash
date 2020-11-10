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
			assertSnapshot(isCallable(26))
			assertSnapshot(isCallable(false))
			assertSnapshot(isCallable("hoop"))
			assertSnapshot(isCallable({}))
			assertSnapshot(isCallable(function() end))
			assertSnapshot(isCallable(callable))
		end)
	end)
end
