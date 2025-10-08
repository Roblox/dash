local Packages = game:GetService("ReplicatedStorage").Packages
local Dash = require(Packages.Dash)
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

benchmark("join", 1000, function()
	Dash.join(DICT_A, DICT_B, DICT_C)
end)
