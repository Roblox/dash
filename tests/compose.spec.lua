local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local compose = Dash.compose

describe("compose", function()
	it("should return identity for no inputs", function()
		local fn = compose()
		expect(fn(126)).toEqual(126)
	end)
	it("should return single function for one input", function()
		local fn = compose(function(input)
			return input + 5
		end)
		expect(fn(126)).toEqual(131)
	end)
	it("should compose functions in correct order for multiple inputs", function()
		local fn = compose(function(input)
			return input + 5
		end, function(input)
			return input * 4
		end, function(input)
			return input + 0.2
		end)
		expect(fn(5)).toEqual(40.2)
	end)
end)
