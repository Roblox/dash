return function()
	local Dash = require(script.Parent)
	local identity = Dash.identity

	describe("identity", function()
		it("should return the input", function()
			local output = {}
			assertSnapshot(identity(output) == output)
			assertSnapshot(identity(5) == 5)
			assertSnapshot(identity(true) == true)
			assertSnapshot(identity("hula") == "hula")
			assertSnapshot(identity(nil) == nil)
		end)
	end)
end
