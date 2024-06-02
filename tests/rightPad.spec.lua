return function()
	local Dash = require(script.Parent)
	local rightPad = Dash.rightPad

	describe("rightPad", function()
		it("should run correctly for a range of inputs", function()
			assertSnapshot(rightPad("toast", 6), [["toast "]])
			assertSnapshot(rightPad("2", 2, "!"), [["2!"]])
			assertSnapshot(rightPad("toast", 10, ":)"), [["toast:):):"]])
		end)
	end)
end
