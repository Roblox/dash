local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local collectSet = Dash.collectSet

describe("collectSet", function()
	it("should collect values from a map into a new set using the default handler", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = collectSet(input)
		expect(output).toEqual({ [10] = true, [20] = true, [30] = true, [50] = true })
	end)

	it("should collect elements from a map into a new set", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = collectSet(input, function(key, value)
			return value .. "=" .. key
		end)
		expect(output).toEqual({ ["10=a"] = true, ["20=b"] = true, ["30=c"] = true, ["50=d"] = true })
	end)
end)
