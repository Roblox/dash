return function()
	local Dash = require(script.Parent)
	local trim = Dash.trim

	describe("trim", function()
		it("can remove whitespace from before and after the end of a string", function()
			assertSnapshot(trim(" space at the start"))
			assertSnapshot(trim("spaces at the end   "))
			assertSnapshot(trim("  spaces both sides  "))
			assertSnapshot(trim("	  	mixed tabs and spaces 		"))
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				trim()
			end, [[AssertError: Attempted to call Dash.trim with argument #1 of type "nil" not "string"]])
		end)
	end)
end