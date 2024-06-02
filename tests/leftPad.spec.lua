return function()
	local Dash = require(script.Parent)
	local leftPad = Dash.leftPad

	describe("leftPad", function()
		it("should run correctly for a range of inputs", function()
			assertSnapshot(leftPad("toast", 6), [[" toast"]])
			assertSnapshot(leftPad("2", 2, "0"), [["02"]])
			assertSnapshot(leftPad("toast", 10, ":)"), [[":):):toast"]])
		end)
	end)
end
