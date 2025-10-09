local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local JestBenchmark = require(Packages.Dev.JestBenchmark)
local describe = JestGlobals.describe
local benchmark = JestBenchmark.benchmark

return function<T>(name: string, times: number, benchFunction: (args: T) -> (), setupFunction: ((runId: number) -> T)?)
	assert(typeof(name) == "string", "name must be a string")
	assert(typeof(times) == "number", "times must be a number")
	assert(typeof(benchFunction) == "function", "benchFunction must be a function")

	local benchArgs = {}

	if setupFunction then
		for runId = 1, times do
			benchArgs[runId] = setupFunction(runId)
		end
	end

	describe(name, function()
		benchmark(`{name} ({times} times)`, function()
			for runId = 1, times do
				benchFunction(benchArgs[runId])
			end
		end)
	end)
end
