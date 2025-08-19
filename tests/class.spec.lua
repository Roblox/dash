local Packages = game:GetService("ReplicatedStorage").Packages
local JestGlobals = require(Packages.Dev.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

local Dash = require(Packages.Dash)
local class = Dash.class
local format = Dash.format

local customMatchers = require(script.Parent.customMatchers)
expect.extend(customMatchers)

describe("class", function()
	it("should create a class with a default constructor", function()
		local Vehicle = class("Vehicle")
		function Vehicle:getWheelCount()
			return 4
		end
		local car = Vehicle.new()
		expect(car:getWheelCount()).toEqual(4)
		expect(tostring(car)).toEqual("Vehicle")
	end)

	it("should create a class with a custom constructor and name", function()
		local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
			return {
				name = name,
				wheelCount = wheelCount,
			}
		end)
		function Vehicle:getWheelCount()
			return self.wheelCount
		end
		local car = Vehicle.new("Car", 8)
		expect(car:getWheelCount()).toEqual(8)
		expect(tostring(car)).toEqual("Car")
	end)

	it("can use a custom toString representation", function()
		local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
			return {
				name = name,
				wheelCount = wheelCount,
			}
		end)
		function Vehicle:toString()
			return format("Vehicle({name})", self)
		end
		local car = Vehicle.new("Car", 8)
		expect(tostring(car)).toEqual("Vehicle(Car)")
	end)

	it("can use a custom equality operator", function()
		local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
			return {
				name = name,
				wheelCount = wheelCount,
			}
		end)
		function Vehicle:equals(other)
			return self.wheelCount == other.wheelCount
		end
		function Vehicle:__lt(other)
			return self.wheelCount < other.wheelCount
		end
		function Vehicle:__gt(other)
			return self.wheelCount > other.wheelCount
		end
		local car = Vehicle.new("Car1", 4)
		local car2 = Vehicle.new("Car2", 8)
		local car3 = Vehicle.new("Car3", 8)
		expect(car == car2).toEqual(false)
		expect(car == car3).toEqual(false)
		expect(car2 == car3).toEqual(true)
		expect(car < car2).toEqual(true)
		expect(car < car3).toEqual(true)
		expect(car2 < car3).toEqual(false)
		expect(car > car2).toEqual(false)
		expect(car > car3).toEqual(false)
		expect(car2 > car3).toEqual(false)
	end)

	it("can use a custom math operators", function()
		local Vehicle = class("Vehicle")
		function Vehicle:getWheelCount()
			return 4
		end
		function Vehicle:__add(other)
			return self:getWheelCount() + other:getWheelCount()
		end
		function Vehicle:__mul(other)
			return self:getWheelCount() * other:getWheelCount()
		end
		function Vehicle:__sub(other)
			return self:getWheelCount() - other:getWheelCount()
		end
		function Vehicle:__div(other)
			return self:getWheelCount() / other:getWheelCount()
		end
		function Vehicle:__mod(other)
			return self:getWheelCount() % other:getWheelCount()
		end
		local car = Vehicle.new()
		local car2 = Vehicle.new()
		expect(car + car2).toEqual(8)
		expect(car * car2).toEqual(16)
		expect(car - car2).toEqual(0)
		expect(car / car2).toEqual(1)
		expect(car % car2).toEqual(0)
	end)

	it("throws for operators which are not implemented", function()
		local Vehicle = class("Vehicle")
		local car = Vehicle.new()
		local car2 = Vehicle.new()
		expect(function()
			return car + car2
		end).toThrowWithMessage([[NotImplemented: The method "__add" is not implemented on the class "Vehicle"]])
		expect(function()
			return car * car2
		end).toThrowWithMessage([[NotImplemented: The method "__mul" is not implemented on the class "Vehicle"]])
		expect(function()
			return car - car2
		end).toThrowWithMessage([[NotImplemented: The method "__sub" is not implemented on the class "Vehicle"]])
		expect(function()
			return car / car2
		end).toThrowWithMessage([[NotImplemented: The method "__div" is not implemented on the class "Vehicle"]])
		expect(function()
			return car % car2
		end).toThrowWithMessage([[NotImplemented: The method "__mod" is not implemented on the class "Vehicle"]])
	end)

	it("can extend a class with independent methods", function()
		local Vehicle = class("Vehicle")
		function Vehicle:getWheelCount()
			return 4
		end
		local Bike = Vehicle:extend("Bike")
		function Bike:getWheelCount()
			return 2
		end
		function Bike:drive() end
		local car = Vehicle.new()
		local bike = Bike.new()
		expect(tostring(car)).toEqual("Vehicle")
		expect(car:getWheelCount()).toEqual(4)
		expect(typeof(car.drive)).toEqual("nil")
		expect(typeof(bike.drive)).toEqual("function")
		expect(tostring(bike)).toEqual("Bike")
		expect(bike:getWheelCount()).toEqual(2)
	end)

	it("can extend a subclass with independent methods", function()
		local Vehicle = class("Vehicle")
		function Vehicle:getWheelCount()
			return 4
		end
		local Bike = Vehicle:extend("Bike")
		function Bike:getWheelCount()
			return 2
		end
		function Bike:getColor()
			return "blue"
		end
		local RedBike = Bike:extend("RedBike")
		function RedBike:getColor()
			return "red"
		end
		local bike = Bike.new()
		local redBike = RedBike.new()
		expect(tostring(bike)).toEqual("Bike")
		expect(bike:getWheelCount()).toEqual(2)
		expect(bike:getColor()).toEqual("blue")
		expect(tostring(redBike)).toEqual("RedBike")
		expect(redBike:getWheelCount()).toEqual(2)
		expect(redBike:getColor()).toEqual("red")
	end)

	it("can use isInstance to detect for class membership", function()
		local Vehicle = class("Vehicle")
		local Bike = Vehicle:extend("Bike")
		local RedBike = Bike:extend("RedBike")
		local bike = Bike.new()
		local redBike = RedBike.new()
		expect(RedBike.isInstance(redBike)).toEqual(true)
		expect(Bike.isInstance(redBike)).toEqual(true)
		expect(Vehicle.isInstance(redBike)).toEqual(true)
		expect(RedBike.isInstance(bike)).toEqual(false)
	end)
end)
