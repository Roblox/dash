return function()
	local Dash = require(script.Parent)
	local identity = Dash.identity

	describe("identity", function()
		it("should return the input", function()
			local output = {}
			assertSnapshot(identity(output) == output, [[true]])
			assertSnapshot(identity(5) == 5, [[true]])
			assertSnapshot(identity(true) == true, [[true]])
			assertSnapshot(identity("hula") == "hula", [[true]])
			assertSnapshot(identity(nil) == nil, [[true]])
		end)
	end)
end
