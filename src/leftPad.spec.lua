return function()
	local Dash = require(script.Parent)
	local leftPad = Dash.leftPad

	describe("leftPad", function()
		it("should run correctly for a range of inputs", function()
			assertSnapshot(leftPad("toast", 6), [[" toast"]])
			assertSnapshot(leftPad("2", 2, "0"), [["02"]])
			assertSnapshot(leftPad("toast", 10, ":)"), [[":):):toast"]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				leftPad()
			end, [[AssertError: Attempted to call Dash.leftPad with argument #1 of type "nil" not "string"]])
		end)

		it("ensures a length of the correct type", function()
			assertThrows(function()
				leftPad("test")
			end, [[AssertError: Attempted to call Dash.leftPad with argument #2 of type "nil" not "number"]])
		end)

		it("ensures a prefix of the correct type", function()
			assertThrows(function()
				leftPad("test", 2, true)
			end, [[AssertError: Attempted to call Dash.leftPad with argument #3 of type "boolean" not "string"]])
		end)
	end)
end
