local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local format = Dash.format

describe("format", function()
	it("should format arguments", function()
		expect(format("Hello {} please meet {}", "orc", "fate")).toEqual("Hello orc please meet fate")
	end)
	it("should format positional arguments", function()
		expect(format("Hello {2} please meet {1}", "orc", "fate")).toEqual("Hello fate please meet orc")
	end)
	it("should format named arguments", function()
		expect(format("Hello {name} please meet {fate}", { name = "orc", fate = "your maker" })).toEqual(
			"Hello orc please meet your maker"
		)
	end)
	it("should format using a range of display strings", function()
		expect(format("Hello {} please meet {}", "orc", 25.7)).toEqual("Hello orc please meet 25.700000")
		expect(format("Hello {} please meet {:06X}", "orc", 255)).toEqual("Hello orc please meet 0000FF")
		expect(format("Hello {} please meet {:?}", "orc", { fate = "your maker" })).toEqual(
			'Hello orc please meet {fate = "your maker"}'
		)
		local longString1 =
			format("Hello {} please meet {:#?}", "orc", { fate = "your maker", achievements = { { made = "you" } } })
		expect(longString1).toEqual([[Hello orc please meet {
	achievements = {
		{
			made = "you"
		}
	},
	fate = "your maker"
}]])
		local longString2 = format(
			"Hello {fate:?} please meet {achievements:#?}",
			{ fate = "your maker", achievements = { { made = "you" } } }
		)
		expect(longString2).toEqual([[Hello "your maker" please meet {
	{
		made = "you"
	}
}]])
	end)
end)
