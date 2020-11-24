return function()
	local Dash = require(script.Parent)
	local freeze = Dash.freeze

	describe("freeze", function()
		it("should make keys readonly", function()
			local output = freeze("MyObject", {
				name = "myName",
				red = 255
			})
			assertThrows(function()
				output.red = 256
			end, [[ReadonlyKey: Attempted to write to readonly key "red" of frozen object "MyObject"]])
			assertSnapshot(output.blah, [[nil]])
		end)
		it("should throw for missing keys if so desired", function()
			assertThrows(function()
				local output = freeze("MyObject", {
					name = "myName",
					red = 255
				}, true)
				return output.blue
			end, [[MissingKey: Attempted to read missing key "blue" of frozen object "MyObject"]])
		end)

		it("should print the key used to a reasonable depth", function()
			assertThrows(function()
				local output = freeze("MyObject", {
					name = "myName",
					red = 255
				}, true)

				local key = {name = "key", child = {name = "child", deep = { deeper = { element = 6 }}}}
				key.child.child = key
				return output[key]
			end, [[MissingKey: Attempted to read missing key <0>{child = {child = &0, deep = {deeper = ...}, name = "child"}, name = "key"} of frozen object "MyObject"]])
		end)

		it("ensures an objectName of correct type", function()
			assertThrows(function()
				freeze()
			end, [[AssertError: Attempted to call Dash.freeze with argument #1 of type "nil" not "string"]])
		end)

		it("ensures an object of correct type", function()
			assertThrows(function()
				freeze("example")
			end, [[AssertError: Attempted to call Dash.freeze with argument #2 of type "nil" not "table"]])
		end)
	end)
end
