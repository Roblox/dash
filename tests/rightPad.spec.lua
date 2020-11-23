return function()
	local Dash = require(script.Parent)
	local rightPad = Dash.rightPad

	describe("rightPad", function()
		it("should run correctly for a range of inputs", function()
			assertSnapshot(rightPad("toast", 6), [["toast "]])
			assertSnapshot(rightPad("2", 2, "!"), [["2!"]])
			assertSnapshot(rightPad("toast", 10, ":)"), [["toast:):):"]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				rightPad()
			end, [[AssertError: Attempted to call Dash.rightPad with argument #1 of type "nil" not "string"]])
		end)

		it("ensures a length of the correct type", function()
			assertThrows(function()
				rightPad("test")
			end, [[AssertError: Attempted to call Dash.rightPad with argument #2 of type "nil" not "number"]])
		end)

		it("ensures a prefix of the correct type", function()
			assertThrows(function()
				rightPad("test", 2, true)
			end, [[AssertError: Attempted to call Dash.rightPad with argument #3 of type "boolean" not "string"]])
		end)
	end)
end
