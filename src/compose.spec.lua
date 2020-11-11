return function()
	local Dash = require(script.Parent)
	local compose = Dash.compose

	describe(
		"compose",
		function()
			it(
				"should return identity for no inputs",
				function()
					local fn = compose()
					assertSnapshot(fn(126))
				end
			)
			it(
				"should return single function for one input",
				function()
					local fn = compose(function(input)
						return input + 5
					end)
					assertSnapshot(fn(126))
				end
			)
			it(
				"should compose functions in correct order for multiple inputs",
				function()
					local fn = compose(function(input)
						return input + 5
					end, function(input)
						return input * 5
					end, function(input)
						return input + 0.2
					end)
					assertSnapshot(fn(5))
				end
			)
		end
	)
end
