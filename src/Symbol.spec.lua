return function()
	local Symbol = require(script.Parent.Symbol)

	describe("symbol", function()
		it("should give a unique object", function()
			local CHEESE = Symbol.new("CHEESE")
			local FAKE_CHEESE = Symbol.new("CHEESE")
			local FAKER_CHEESE = {
				name = "CHEESE"
			}
			local FAKEST_CHEESE = Symbol.new("NOT_EVEN_CHEESE")
			assertSnapshot(CHEESE == CHEESE, [[true]])
			assertSnapshot(CHEESE == FAKE_CHEESE, [[false]])
			assertSnapshot(CHEESE == FAKER_CHEESE, [[false]])
			assertSnapshot(CHEESE == FAKEST_CHEESE, [[false]])
		end)

		it("should have a string representation", function()
			local CHEESE = Symbol.new("CHEESE")
			assertSnapshot(tostring(CHEESE), [["Symbol(CHEESE)"]])
		end)

		it("should be a Symbol instance", function()
			local CHEESE = Symbol.new("CHEESE")
			local FAKE_CHEESE = {
				name = "CHEESE"
			}
			assertSnapshot(Symbol.isInstance(CHEESE), [[true]])
			assertSnapshot(Symbol.isInstance(FAKE_CHEESE), [[false]])
		end)
	end)
end