return function()
	local Dash = require(script.Parent)
	local append = Dash.append
	local None = Dash.None

	describe("append", function()
		it("should append to an empty list", function()
			assertSnapshot(append({}, {1, 2, 3}, {4, 5, 6}), [[{
	1,
	2,
	3,
	4,
	5,
	6
}]])
		end)

		it("should append to a list with existing values", function()
			assertSnapshot(append({1, 2}, {3}, {4, 5, 6}), [[{
	1,
	2,
	3,
	4,
	5,
	6
}]])
		end)

		it("should skip nil arguments", function()
			assertSnapshot(append({1, 2}, {3}, {4, 5, 6}), [[{
	1,
	2,
	3,
	4,
	5,
	6
}]])
		end)

		it("should skip None arguments", function()
			assertSnapshot(append({1, 2}, nil, nil, {4, 5, 6}), [[{
	1,
	2,
	4,
	5,
	6
}]])
		end)

		it("should throw with a missing target", function()
			assertThrows(function()
				append()
			end, [[AssertError: Attempted to call Dash.append with argument #1 of type "nil" not "table"]])
		end)

		it("should throw with a target of the wrong type", function()
			assertThrows(function()
				append(true)
			end, [[AssertError: Attempted to call Dash.append with argument #1 of type "boolean" not "table"]])
		end)

	end)
end
