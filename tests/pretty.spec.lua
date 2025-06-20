local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local pretty = Dash.pretty

describe("pretty", function()
	it("should print primitive values", function()
		expect(pretty("stringy")).toEqual([["stringy"]])
		expect(pretty(15)).toEqual([[15]])
		expect(pretty(true)).toEqual([[true]])
		local function myFunction() end
		expect(pretty(myFunction)).toEqual(tostring(myFunction))
	end)

	it("should print a map with string keys", function()
		local input = { a = 10, b = 20, c = 30, d = 50 }
		local output = pretty(input)
		expect(output).toEqual([[{a = 10, b = 20, c = 30, d = 50}]])
	end)

	it("should print an array", function()
		local input = { 10, 20, 30, 50 }
		local output = pretty(input)
		expect(output).toEqual([[{10, 20, 30, 50}]])
	end)

	describe("indentLines function", function()
		it("should indent nested tables with default tab character", function()
			local input = { nested = { a = 1, b = 2 } }
			local output = pretty(input, { multiline = true })
			local lines = output:split("\n")
			expect(lines[2]:sub(1, 1)).toEqual("\t")
		end)

		it("should indent nested tables with custom indent string", function()
			local input = { nested = { a = 1, b = 2 } }
			local output = pretty(input, { multiline = true, indent = "  " })
			local lines = output:split("\n")
			expect(lines[2]:sub(1, 2)).toEqual("  ")
		end)

		it("should indent multiple levels of nesting", function()
			local input = { level1 = { level2 = { level3 = "deep" } } }
			local output = pretty(input, { multiline = true, depth = 5 })
			local lines = output:split("\n")
			expect(lines[2]).toMatch("^\t") -- level1 content
			expect(lines[3]).toMatch("^\t\t") -- level2 content
		end)
	end)

	describe("sortObjectKeys function", function()
		it("should sort numeric keys in ascending order", function()
			local input = { [3] = "three", [1] = "one", [2] = "two" }
			local output = pretty(input)
			expect(output).toEqual([[{"one", "two", "three"}]])
		end)

		it("should sort string keys lexicographically", function()
			local input = { zebra = 1, apple = 2, banana = 3 }
			local output = pretty(input)
			expect(output).toEqual([[{apple = 2, banana = 3, zebra = 1}]])
		end)

		it("should handle mixed key types with numbers first", function()
			local input = { [2] = "two", zebra = 1, [1] = "one", apple = 2 }
			local output = pretty(input)
			expect(output).toEqual([[{"one", "two", apple = 2, zebra = 1}]])
		end)
	end)
end)
