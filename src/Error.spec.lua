return function()
	local Dash = require(script.Parent)
	local Error = Dash.Error

	describe("Error", function()
		it("should correctly create and throw an error", function()
			assertThrows(function()
				local MyError = Error.new("MyError")
				MyError:throw()
			end, [[MyError: An error occurred]])
		end)

		it("should throw an error with a custom message", function()
			assertThrows(function()
				local MyError = Error.new("MyError", "An error did sadly occur")
				MyError:throw()
			end, [[MyError: An error did sadly occur]])
		end)

		it("should throw an error with message formatted with tag values", function()
			assertThrows(function()
				local MyError = Error.new("MyError", "An error happened for {name} due to {reason:?}")
				MyError:throw({
					name = "Digbert",
					reason = {
						hunger = 10
					}
				})
			end, [[An error happened for Digbert due to {hunger=10}]])
		end)

		it("should capture a stack trace", function()
			local function throwError()
				local MyError = Error.new("MyError")
				MyError:throw()
			end
			local ok, problem = pcall(throwError)
			assertSnapshot(ok)
			assertSnapshot(problem.stack)
		end)

	end)
end
