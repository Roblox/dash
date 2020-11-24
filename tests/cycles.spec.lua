return function()
	local Dash = require(script.Parent)
	local cycles = Dash.cycles
	local pretty = Dash.pretty

	describe("cycles", function()
		it("should return nil for a primitive value", function()
			local output = cycles(57)
			assertSnapshot(output, [[nil]])
		end)

		it("should return a cycles breakdown for a non-cyclic table", function()
			local tableA = {a = 2}
			local tableB = {a = 2, b = 4, c = tableB}
			local output = cycles({a = 2, b = 4, c = {a = 2}})
			assertSnapshot(output.nextRef, [[1]])
			assertSnapshot(output.refs, [[{}]])
		end)

		it("should return a cycles breakdown for a cyclic table", function()
			local tableA = {a = 2, b = 4}
			local tableB = {x = 5}
			local tableC = {a = 5, child = tableB}
			tableA.c = tableC
			tableC.a = tableA
			local output = cycles({a = tableA, c = tableC})
			assertSnapshot(output.nextRef, [[3]])
			assertSnapshot(output.refs[tableA], [[1]])
			assertSnapshot(output.refs[tableB], [[nil]])
			assertSnapshot(output.refs[tableC], [[2]])
		end)

	end)
end
