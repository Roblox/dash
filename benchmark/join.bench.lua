local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local JestBenchmark = require(Packages.Dev.JestBenchmark)
local describe = JestGlobals.describe
local benchmark = JestBenchmark.benchmark

local Dash = require(Packages.Dash)

describe("join", function()
	benchmark("join (200 times)", function()
		Dash.join({
			a = 5,
			b = 10,
			cherry = 800,
		}, {
			apple = 50,
			cherry = 80,
			fig = 100,
		}, {
			banana = 10,
			cherry = 100,
			durian = 1000,
		})
	end)
end)
