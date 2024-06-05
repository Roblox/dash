local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local count = Dash.count

describe("count", function()
	it("should return number of elements satisfying handler condition", function()
		local input = { a = 5, b = 6, c = 7, d = 8 }
		local output = count(input, function(value, key)
			return key == "c" or value == 5
		end)
		expect(output).toBe(2)
	end)

	describe("without handler", function()
		-- TODO (AleksandrSl 03/06/2024): Add a case where #input and count will have different output
		it("should count all elements", function()
			local input = { a = 5, b = 5, c = 5, d = 5 }
			local output = count(input)
			expect(output).toBe(4)
		end)
	end)
end)
