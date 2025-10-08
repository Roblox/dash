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
local DICT_C = {
	banana = 10,
	cherry = 100,
	durian = 1000,
}

local BENCHMARK_ITERATIONS = 10_000

benchmark("Dash.join", BENCHMARK_ITERATIONS, function(targetTable)
	Dash.join(targetTable, DICT_A, DICT_B, DICT_C)
end, function()
	return {}
end)

benchmark("Cryo.Dictionary.union", BENCHMARK_ITERATIONS, function(targetTable)
	Cryo.Dictionary.union(targetTable, DICT_A)
	Cryo.Dictionary.union(targetTable, DICT_B)
	Cryo.Dictionary.union(targetTable, DICT_C)
end, function()
	return {}
end)
