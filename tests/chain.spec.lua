local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect
local jest = JestGlobals.jest

local Dash = require(Packages.Dash)
local chain = Dash.chain

describe.only("chain", function()
	it("should chain iterators in the correct order", function()
		local function statefulIterator<T>(list: { T })
			local index = 0
			local count = #list

			return function()
				index = index + 1
				if index <= count then
					return list[index]
				end
				return nil
			end
		end

		local iterator1 = statefulIterator({ 1, 2, 3 })
		local iterator2 = statefulIterator({ 4, 5, 6 })
		local iterator3 = statefulIterator({ -1, -2, -3 })

		local values = {}

		for first in chain(iterator1, iterator2, iterator3) do
			table.insert(values, first)
		end

		expect(values).toEqual({ 1, 2, 3, 4, 5, 6, -1, -2, -3 })
	end)

	it("should be lazy", function()
		local mockFn = jest.fn()
		local function statefulIterator<T>(list: { T })
			local index = 0
			local count = #list

			return function()
				mockFn()
				index = index + 1
				if index <= count then
					return list[index]
				end
				return nil
			end
		end

		local iterator1 = statefulIterator({ 1, 2, 3 })
		local iterator2 = statefulIterator({ 4, 5, 6 })
		local iterator3 = statefulIterator({ -1, -2, -3 })

		for value in chain(iterator1, iterator2, iterator3) do
			if value == 2 then
				break
			end
		end

		expect(mockFn).toHaveBeenCalledTimes(2)
	end)

	it("should return all results for multiple return functions", function()
		local function statefulIterator<T>(list: { T })
			local index = 0
			local count = #list

			return function()
				index = index + 1
				if index <= count then
					return index, list[index]
				end
				return nil
			end
		end

		local iterator1 = statefulIterator({ 1, 2, 3 })
		local iterator2 = statefulIterator({ 4, 5, 6 })
		local iterator3 = statefulIterator({ -1, -2, -3 })

		local values = {}

		for index, value in chain(iterator1, iterator2, iterator3) do
			table.insert(values, { index, value })
		end

		expect(values).toEqual({
			{ 1, 1 },
			{ 2, 2 },
			{ 3, 3 },
			{ 1, 4 },
			{ 2, 5 },
			{ 3, 6 },
			{ 1, -1 },
			{ 2, -2 },
			{ 3, -3 },
		})
	end)
end)
