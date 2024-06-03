local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local Symbol = Dash.Symbol

describe("symbol", function()
	it("should give a unique object", function()
		local CHEESE = Symbol.new("CHEESE")
		local FAKE_CHEESE = Symbol.new("CHEESE")
		local FAKER_CHEESE = {
			name = "CHEESE",
		}
		local FAKEST_CHEESE = Symbol.new("NOT_EVEN_CHEESE")
		expect(CHEESE == CHEESE).toBe(true)
		expect(CHEESE == FAKE_CHEESE).toBe(false)
		expect(CHEESE == FAKER_CHEESE).toBe(false)
		expect(CHEESE == FAKEST_CHEESE).toBe(false)
	end)

	it("should have a string representation", function()
		local CHEESE = Symbol.new("CHEESE")
		expect(tostring(CHEESE)).toEqual("Symbol(CHEESE)")
	end)

	it("should be a Symbol instance", function()
		local CHEESE = Symbol.new("CHEESE")
		local FAKE_CHEESE = {
			name = "CHEESE",
		}
		expect(Symbol.isInstance(CHEESE)).toBe(true)
		expect(Symbol.isInstance(FAKE_CHEESE)).toBe(false)
	end)
end)
