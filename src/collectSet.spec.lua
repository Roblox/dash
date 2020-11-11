return function()
	local Dash = require(script.Parent)
	local collectSet = Dash.collectSet

	describe("collectSet", function()
		it("should collect values from a map into a new set using the default handler", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collectSet(input)
			assertSnapshot(output, [[{
	10 = true,
	20 = true,
	30 = true,
	50 = true
}]])
		end)

		it("should collect elements from a map into a new set", function()
			local input = {a = 10, b = 20, c = 30, d = 50}
			local output = collectSet(input, function(key, value)
				return value .. "=" .. key
			end)
			assertSnapshot(output, [[{
	10=a = true,
	20=b = true,
	30=c = true,
	50=d = true
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				collectSet()
			end, [[AssertError: Attempted to call Dash.collectSet with argument #1 of type "nil" not "table"]])
		end)

	end)
end
