return function()
	local Dash = require(script.Parent)
	local iterable = Dash.iterable
	local iterator = Dash.iterator
	local slice = Dash.slice

	local insert = table.insert
	local sort = table.sort

	describe("iterator", function()
		it("iterates through an array in order", function()
			local output = {}
			for key, value in iterator({10, 20, 30, 40, 50}) do
				insert(output, key .. "=" .. value)
			end
			assertSnapshot(output, [[{
	"1=10",
	"2=20",
	"3=30",
	"4=40",
	"5=50"
}]])
		end)

		it("iterates through a map in an arbitrary order", function()
			local output = {}
			for key, value in iterator({a = 1, b = 2, c = 3, d = 4, e = 5}) do
				insert(output, key .. "=" .. value)
			end
			sort(output)
			assertSnapshot(output, [[{
	"a=1",
	"b=2",
	"c=3",
	"d=4",
	"e=5"
}]])
		end)

		it("only discovers ordered keys as ipairs assumed", function()
			local output = {}
			for key, value in iterator({10, 20, 30, [5] = 50, a = 1, b = 2, c = 3, d = 4, e = 5}) do
				insert(output, key .. "=" .. value)
			end
			sort(output)
			assertSnapshot(output, [[{
	"1=10",
	"2=20",
	"3=30"
}]])
		end)

		it("discovers unordered keys if forced", function()
			local input = iterable({10, 20, 30, [5] = 50, a = 1, b = 2, c = 3, d = 4, e = 5})
			local output = {}
			for key, value in iterator(input) do
				insert(output, key .. "=" .. value)
			end
			assertSnapshot(slice(output, 1, 3), [[{
	"1=10",
	"2=20",
	"3=30"
}]])
			sort(output)
			assertSnapshot(output, [[{
	"1=10",
	"2=20",
	"3=30",
	"5=50",
	"a=1",
	"b=2",
	"c=3",
	"d=4",
	"e=5"
}]])
		end)
	end)
end
