return function()
	local Dash = require(script.Parent)
	local splitOn = Dash.splitOn

	describe("splitOn", function()
		it("should return a array with a single element for an empty string", function()
			local output = splitOn("", "[.:()]")
			assertSnapshot(output, [[{
	""
}]])
		end)
		it("should split a string based on a pattern", function()
			local output = splitOn("zombie.Head.Part:Connect()", "[.:()]")
			assertSnapshot(output, [[{
	"zombie",
	"Head",
	"Part",
	"Connect",
	"",
	""
}]])
		end)
	end)
end
