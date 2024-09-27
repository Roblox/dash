local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local cycles = Dash.cycles

describe("cycles", function()
	it("should return nil for a primitive value", function()
		local output = cycles(57)
		expect(output).toBeNil()
	end)

	it("should return a cycles breakdown for a non-cyclic table", function()
		local output = cycles({ a = 2, b = 4, c = { a = 2 } })
		expect(output.nextRef).toEqual(1)
		expect(output.refs).toEqual({})
	end)

	it("should return a cycles breakdown for a cyclic table", function()
		local tableA = { a = 2, b = 4 }
		local tableB = { x = 5 }
		local tableC = { a = 5, child = tableB }
		tableA.c = tableC
		tableC.a = tableA
		local output = cycles({ a = tableA, c = tableC })
		expect(output.nextRef).toEqual(3)
		expect(output.refs[tableA]).toEqual(1)
		expect(output.refs[tableB]).toBeNil()
		expect(output.refs[tableC]).toEqual(2)
	end)
end)
