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
			expect(CHEESE).to.equal(CHEESE)
			expect(CHEESE).never.to.equal(FAKE_CHEESE)
			expect(CHEESE).never.to.equal(FAKER_CHEESE)
			expect(CHEESE).never.to.equal(FAKEST_CHEESE)
		end)

		it("should have a string representation", function()
			local CHEESE = Symbol.new("CHEESE")
			expect(tostring(CHEESE)).to.equal("Symbol(CHEESE)")
		end)

		it("should be a Symbol instance", function()
			local CHEESE = Symbol.new("CHEESE")
			local FAKE_CHEESE = {
				name = "CHEESE"
			}
			expect(Symbol.isInstance(CHEESE)).to.equal(true)
			expect(Symbol.isInstance(FAKE_CHEESE)).to.equal(false)
		end)
	end)
end