return function()
	local Dash = require(script.Parent)
	local collectArray = Dash.collectArray
	local sort = table.sort

	describe("collectArray", function()
		it("should collect elements from a map into a new array", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collectArray(input, function(key, value)
				return value .. "=" .. key
			end)
			sort(output)
			assertSnapshot(output, [[{
	"10=a",
	"20=b",
	"30=c",
	"50=d"
}]])
		end)
	end)
end
