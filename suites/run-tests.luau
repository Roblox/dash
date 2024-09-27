local ReplicatedStorage = game:GetService("ReplicatedStorage")
local processServiceExists, ProcessService = pcall(function()
	return game:GetService("ProcessService")
end)

local Packages = ReplicatedStorage:FindFirstChild("Packages")
if not Packages or not Packages:FindFirstChild("Dev") then
	game:GetService("TestService"):Error("Invalid Package configuration. Try running `rotrieve install` to remedy.")
	ProcessService:ExitAsync(1)
end

local runCLI = require(Packages.Dev.Jest).runCLI

local status, result = runCLI(Packages.Dash, {}, { Packages.Dash }):awaitStatus()

if status == "Rejected" then
	print(result)
end

if status == "Resolved" and result.results.numFailedTestSuites == 0 and result.results.numFailedTests == 0 then
	if processServiceExists then
		ProcessService:ExitAsync(0)
	end
end

if processServiceExists then
	ProcessService:ExitAsync(1)
end

local statusCode = if result.results.failureCount == 0 then 0 else 1

ProcessService:ExitAsync(statusCode)
