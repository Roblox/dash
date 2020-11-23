return function()
	local Dash = require(script.Parent)
	local join = Dash.join
	local None = Dash.None

	describe("join", function()
		it("should join a tables together", function()
			assertSnapshot(join({c = 4}, {a = 1}, {b = 2, c = None}), [[{
	a = 1,
	b = 2
}]])
		end)

		it("should skip nil arguments", function()
			assertSnapshot(join({a = 1, b = 2}, nil, nil, {c = 3}), [[{
	a = 1,
	b = 2,
	c = 3
}]])
		end)

		it("should skip None arguments", function()
			assertSnapshot(join({a = 1, b = 2}, None, None, {c = 3}), [[{
	a = 1,
	b = 2,
	c = 3
}]])
		end)

		it("should not mutate the original input", function()
			local input = {a = 1, b = 2}
			assertSnapshot(join(input, {b = 4}, {c = 3}), [[{
	a = 1,
	b = 4,
	c = 3
}]])
			assertSnapshot(input, [[{
	a = 1,
	b = 2
}]])
		end)
	end)
end
