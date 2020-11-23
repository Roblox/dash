return function()
	local Dash = require(script.Parent)
	local forEach = Dash.forEach

	local insert = table.insert
	local sort = table.sort

	describe("forEach", function()
		it("should iterate through elements of an array", function()
			local output = {}
			forEach({1, 2, 3, 4, 5}, function(value, key)
				insert(output, key + value)
			end)
			assertSnapshot(output, [[{
	2,
	4,
	6,
	8,
	10
}]])
		end)

		it("should iterate through elements of a map", function()
			local output = {}
			forEach({a = 1, b = 2, c = 3}, function(value, key)
				insert(output, key .. "=" .. value)
			end)
			sort(output)
			assertSnapshot(output, [[{
	"a=1",
	"b=2",
	"c=3"
}]])
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				forEach()
			end, [[AssertError: Attempted to call Dash.forEach with argument #1 of type "nil" not "table"]])
		end)

		it("ensures a handler of correct type", function()
			assertThrows(function()
				forEach({})
			end, [[AssertError: Attempted to call Dash.forEach with argument #2 of type "nil" not "function"]])
		end)
	end)
end
