return function()
	local Dash = require(script.Parent)
	local format = Dash.format

	describe("format", function()
		it("should format arguments", function()
			assertSnapshot(format("Hello {} please meet {}", "orc", "fate"), [["Hello orc please meet fate"]])
		end)
		it("should format positional arguments", function()
			assertSnapshot(format("Hello {2} please meet {1}", "orc", "fate"), [["Hello fate please meet orc"]])
		end)
		it("should format named arguments", function()
			assertSnapshot(format("Hello {name} please meet {fate}", {name = "orc", fate = "your maker"}), [["Hello orc please meet your maker"]])
		end)
		it("should format using a range of display strings", function()
			assertSnapshot(format("Hello {} please meet {}", "orc", 25.7), [["Hello orc please meet 25.700000"]])
			assertSnapshot(format("Hello {} please meet {:06X}", "orc", 255), [["Hello orc please meet 0000FF"]])
			assertSnapshot(format("Hello {} please meet {:?}", "orc", {fate = "your maker"}), [["Hello orc please meet {fate = "your maker"}"]])
			local longString1 = format("Hello {} please meet {:#?}", "orc", {fate = "your maker", achievements = {{made = "you"}}})
			assertSnapshot(longString1, [["Hello orc please meet {
	achievements = {
		{
			made = "you"
		}
	},
	fate = "your maker"
}"]])
			local longString2 = format("Hello {fate:?} please meet {achievements:#?}", {fate = "your maker", achievements = {{made = "you"}}})
			assertSnapshot(longString2, [["Hello "your maker" please meet {
	{
		made = "you"
	}
}"]])
		end)
	end)
end
