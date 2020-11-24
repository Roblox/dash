return function()
	local Dash = require(script.Parent)
	local Symbol = Dash.Symbol
	local None = Dash.None

	describe("None", function()
		it("should be represented by a symbol", function()
			assertSnapshot(Symbol.isInstance(None), [[true]])
			assertSnapshot(tostring(None), [["Symbol(None)"]])
		end)
	end)
end
