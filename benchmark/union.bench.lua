local Packages = game:GetService("ReplicatedStorage").Packages
local Dash = require(Packages.Dash)
local Cryo = require(Packages.Dev.Cryo)
local benchmark = require(script.Parent.benchmark)

local DICT_A = {
	a = 5,
	b = 10,
	cherry = 800,
}
local DICT_B = {
	apple = 50,
	cherry = 80,
	fig = 100,
}

local BENCHMARK_ITERATIONS = 10_000

benchmark("Dash.union", BENCHMARK_ITERATIONS, function()
	Dash.union(DICT_A, DICT_B)
end)

benchmark("Cryo.Dictionary.union", BENCHMARK_ITERATIONS, function()
	Cryo.Dictionary.union(DICT_A, DICT_B)
end)
