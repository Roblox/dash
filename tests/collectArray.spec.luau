local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local collectArray = Dash.collectArray
local sort = table.sort

describe("collectArray", function()
	it("should collect elements from a map into a new array", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = collectArray(input, function(key, value)
			return value .. "=" .. key
		end)
		sort(output)
		expect(output).toEqual({ "10=a", "20=b", "30=c", "50=d" })
	end)
end)
