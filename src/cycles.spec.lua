return function()
	local Dash = require(script.Parent)
	local cycles = Dash.cycles

	describe("cycles", function()
		it("should return nil for a primitive value", function()
			local output = cycles(57)
			assertSnapshot(output, [[nil]])
		end)

		it("should return a cycles breakdown for a non-cyclic table", function()
			local output = cycles({a = 2, b = 4, c = {a = 2}})
			assertSnapshot(output)
		end)

		it("should return a cycles breakdown for a cyclic table", function()
			local tableA = {a = 2, b = 4}
			local tableC = {a = 5}
			tableA.c = tableC
			tableC.a = tableA
			local output = cycles({a = tableA, c = tableC})
			assertSnapshot(output)
		end)

	end)
end
