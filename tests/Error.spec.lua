local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local Error = Dash.Error

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("Error", function()
	it("should correctly create and throw an error", function()
		expect(function()
			local MyError = Error.new("MyError")
			MyError:throw()
		end).toThrowWithMessage([[MyError: An error occurred]])
	end)

	it("should throw an error with a custom message", function()
		expect(function()
			local MyError = Error.new("MyError", "An error did sadly occur")
			MyError:throw()
		end).toThrowWithMessage([[MyError: An error did sadly occur]])
	end)

	it("should throw an error with message formatted with tag values", function()
		expect(function()
			local MyError = Error.new("MyError", "An error happened for {name} due to {reason:?}")
			MyError:throw({
				name = "Eggbert",
				reason = {
					hunger = 10,
				},
			})
		end).toThrowWithMessage([[MyError: An error happened for Eggbert due to {hunger = 10}]])
	end)

	it("should capture a stack trace", function()
		local function throwError()
			local MyError = Error.new("MyError")
			MyError:throw()
		end
		local ok, problem = pcall(throwError)
		expect(ok).toEqual(false)
		expect(typeof(problem.stack)).toEqual("string")
	end)
end)
