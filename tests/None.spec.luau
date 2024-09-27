local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local Symbol = Dash.Symbol
local None = Dash.None

describe("None", function()
	it("should be represented by a symbol", function()
		expect(Symbol.isInstance(None)).toBe(true)
		expect(tostring(None)).toEqual("Symbol(None)")
	end)
end)
