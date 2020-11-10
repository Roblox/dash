return function()
	local Dash = require(script.Parent)
	local class = Dash.class
	local format = Dash.format

	describe("class", function()
		it("should create a class with a default constructor", function()
			local Vehicle = class("Vehicle")
			function Vehicle:getWheelCount()
				return 4
			end
			local car = Vehicle.new()
			assertSnapshot(car:getWheelCount(), [[4]])
			assertSnapshot(tostring(car), [["Vehicle"]])
		end)

		it("should create a class with a custom constructor and name", function()
			local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
				return {
					name = name,
					wheelCount = wheelCount
				}
			end)
			function Vehicle:getWheelCount()
				return self.wheelCount
			end
			local car = Vehicle.new("Car", 8)
			assertSnapshot(car:getWheelCount(), [[8]])
			assertSnapshot(tostring(car), [["Car"]])
		end)

		it("can use a custom toString representation", function()
			local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
				return {
					name = name,
					wheelCount = wheelCount
				}
			end)
			function Vehicle:toString()
				return format("Vehicle({name})", self)
			end
			local car = Vehicle.new("Car", 8)
			assertSnapshot(tostring(car), [["Vehicle(Car)"]])
		end)

		it("can use a custom equality operator", function()
			local Vehicle = class("Vehicle", function(name: string, wheelCount: string)
				return {
					name = name,
					wheelCount = wheelCount
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
			assertSnapshot(car == car2, [[false]])
			assertSnapshot(car == car3, [[false]])
			assertSnapshot(car2 == car3, [[true]])
			assertSnapshot(car < car2, [[true]])
			assertSnapshot(car < car3, [[true]])
			assertSnapshot(car2 < car3, [[false]])
			assertSnapshot(car > car2, [[false]])
			assertSnapshot(car > car3, [[false]])
			assertSnapshot(car2 > car3, [[false]])
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
			assertSnapshot(car + car2, [[8]])
			assertSnapshot(car * car2, [[16]])
			assertSnapshot(car - car2, [[0]])
			assertSnapshot(car / car2, [[1]])
			assertSnapshot(car % car2, [[0]])
		end)

		it("throws for operators which are not implemented", function()
			local Vehicle = class("Vehicle")
			local car = Vehicle.new()
			local car2 = Vehicle.new()
			assertThrows(function()
				return car + car2
			end, [[NotImplemented: The method "__add" is not implemented on the class "Vehicle"]])
			assertThrows(function()
				return car * car2
			end, [[NotImplemented: The method "__mul" is not implemented on the class "Vehicle"]])
			assertThrows(function()
				return car - car2
			end, [[NotImplemented: The method "__sub" is not implemented on the class "Vehicle"]])
			assertThrows(function()
				return car / car2
			end, [[NotImplemented: The method "__div" is not implemented on the class "Vehicle"]])
			assertThrows(function()
				return car % car2
			end, [[NotImplemented: The method "__mod" is not implemented on the class "Vehicle"]])
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
			function Bike:drive()
			end
			local car = Vehicle.new()
			local bike = Bike.new()
			assertSnapshot(tostring(car), [["Vehicle"]])
			assertSnapshot(car:getWheelCount(), [[4]])
			assertSnapshot(car.drive, [[nil]])
			assertSnapshot(tostring(bike), [["Bike"]])
			assertSnapshot(bike:getWheelCount(), [[2]])
			
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
			assertSnapshot(tostring(bike), [["Bike"]])
			assertSnapshot(bike:getWheelCount(), [[2]])
			assertSnapshot(bike:getColor(), [["blue"]])
			assertSnapshot(tostring(redBike), [["RedBike"]])
			assertSnapshot(redBike:getWheelCount(), [[2]])
			assertSnapshot(redBike:getColor(), [["red"]])
			
		end)
	end)
end
