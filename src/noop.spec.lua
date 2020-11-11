return function()
	local Dash = require(script.Parent)
	local noop = Dash.noop

	describe("noop", function()
		it("should run without error and return nil", function()
			assertSnapshot(noop(), [[nil]])
		end)
	end)
end
