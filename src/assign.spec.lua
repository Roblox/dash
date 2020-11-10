return function()
	local Dash = require(script.Parent)
	local assign = Dash.assign
	local None = Dash.None

	describe("assign", function()
		it("should assign to an empty table", function()
			local input = {}
			local output = assign(input, {a = 1}, {b = 2})
			assertSnapshot(output, [[{
	a = 1,
	b = 2
}]])
			assertSnapshot(input == output)
		end)

		it("should assign to a table with existing values, overwriting existing keys", function()
			assertSnapshot(assign({a = 1}, {a = 2, b = 3}, {b = 4}), [[{
	a = 2,
	b = 4
}]])
		end)

		it("should skip nil arguments", function()
			assertSnapshot(assign({a = 1, b = 2}, nil, nil, {c = 3}), [[{
	a = 1,
	c = 3,
	b = 2
}]])
		end)

		it("should skip None arguments", function()
			assertSnapshot(assign({a = 1, b = 2}, None, None, {c = 3}), [[{
	a = 1,
	c = 3,
	b = 2
}]])
		end)

		it("should throw with a missing target", function()
			assertThrows(function()
				assign()
			end, [[AssertError: Attempted to call Dash.assign with argument #1 of type "nil" not "table"]])
		end)

		it("should throw with a target of the wrong type", function()
			assertThrows(function()
				assign(true)
			end, [[AssertError: Attempted to call Dash.assign with argument #1 of type "boolean" not "table"]])
		end)

	end)
end
