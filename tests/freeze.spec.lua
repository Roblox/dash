local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local freeze = Dash.freeze

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("freeze", function()
	it("should make keys readonly", function()
		local output = freeze("MyObject", {
			name = "myName",
			red = 255,
		})
		expect(function()
			output.red = 256
		end).toThrowWithMessage([[ReadonlyKey: Attempted to write to readonly key "red" of frozen object "MyObject"]])
		expect(output.blah).toBeNil()
	end)
	it("should throw for missing keys if so desired", function()
		expect(function()
			local output = freeze("MyObject", {
				name = "myName",
				red = 255,
			}, true)
			return output.blue
		end).toThrowWithMessage([[MissingKey: Attempted to read missing key "blue" of frozen object "MyObject"]])
	end)

	it("should print the key used to a reasonable depth", function()
		expect(function()
			local output = freeze("MyObject", {
				name = "myName",
				red = 255,
			}, true)

			local key = { name = "key", child = { name = "child", deep = { deeper = { element = 6 } } } }
			key.child.child = key
			return output[key]
		end).toThrowWithMessage(
			[[MissingKey: Attempted to read missing key <0>{child = {child = &0, deep = {deeper = ...}, name = "child"}, name = "key"} of frozen object "MyObject"]]
		)
	end)
end)
