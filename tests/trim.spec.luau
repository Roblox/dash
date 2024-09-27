local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local trim = Dash.trim

describe("trim", function()
	it("can remove whitespace from before and after the end of a string", function()
		expect(trim(" space at the start")).toEqual("space at the start")
		expect(trim("spaces at the end   ")).toEqual("spaces at the end")
		expect(trim("  spaces both sides  ")).toEqual("spaces both sides")
		expect(trim("	  	mixed tabs and spaces 		")).toEqual("mixed tabs and spaces")
		expect(trim("	  	!@#$%^&*()_-+=`~[]{}//\\ 		")).toEqual("!@#$%^&*()_-+=`~[]{}//\\")
	end)
end)
