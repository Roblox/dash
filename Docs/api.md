# API Reference

## Types

### Map

```luau
type Map<Key, Value> = {[Key]: Value}
```

A table with keys of type _Key_ and values of type _Value_

<hr>

### Set

```luau
type Set<Key> = {[Key]: boolean}
```

A table with keys of a fixed type _Key_ and a boolean value representing membership of the set (default is false)

<hr>

### Table

```luau
type Table = {[any]: any}
```

A table of any type

<hr>

### Class

```luau
type Class<Object> = {
    new: () -> Object
}
```

A class has a constructor returning an instance of _Object_ type

<hr>

### Handlers

Some functions such as [filter](#filter) will require handlers. There will be a `Key` and `Value` type to denote whether the key or value argument is passed first, but they are both `any` type unless otherwise specified.

<hr>

### AnyFunction
```luau
type AnyFunction = (...any) -> any
```
Represents a function which takes any arguments and returns any value

<hr>

## Tables

These utilities operate on [Tables](#table) of any kind.

<hr>

### all

<span class="tags">
	[Tables](#tables)
</span>

```lua
type AllHandler = (Value, Key) -> boolean

all(input: types.Table, handler: AllHandler?): boolean
```

Iterates through all elements of the _input_ [Table](#table).

Calls the _handler_ for each entry and returns `false` if the handler returns falsy for any element which it is called with. Otherwise, all elements were truthy so return `true`.

If the handler is not provided, use the truthiness of the values in the table.

**Examples**

```luau
-- These are the only falsy values in Lua
Dash.all({nil, false}) --> false
```

```luau
Dash.all({true, 0, "0"}) --> true
```

```luau
-- Do all words start with 'ro'?
Dash.all(
	{"roblox", "roact", "rodux"},
	function(word) return Dash.startsWith(word, "ro") end
)
--[[
Output: true
]]

```

<hr>

### collect

<span class="tags">
	[Tables](#tables)
</span>

```lua
type CollectHandler = (Key, Value) -> (any, any)?

collect(input: Types.Table, handler: CollectHandler): Types.Map<any, any>
```

Collect returns a new [Table](#table) derived from _input_ by iterating through its pairs and calling
the handler on each `(key, value)` tuple.

The handler should return a new `(newKey, value)` tuple to be inserted into the returned Table,
or `nil` if no value should be added.

**Example**

```luau
-- Invert keys and values of a table
Dash.collect({a = "1", b = "2", c = 3}, function(key, value)
	return value, key
end)

--[[
Output: {
	[3] = "c"
	["1"] = "a",
	["2"] = "b",
}
]]
```

<hr>

### collectArray

<span class="tags">
	[Tables](#tables)
</span>

```lua
type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?

collectArray<Key, Value, NewValue>(input: { [Key]: Value }, handler: CollectHandler<Key, Value, NewValue>): { NewValue }
```

Collect returns a new array derived from _input_ by iterating through its pairs and calling
the handler on each `(key, value)` tuple.

The handler should return a new value to be pushed onto the end of the result array, or `nil`
if no value should be added.

**Example**

```luau
-- Double all elements, ignoring results that are multiples of three
Dash.collectArray({1, 2, 3, 4, 5, 6}, function(key, value)
	local newValue = value * 2
	return if newValue % 3 == 0 then nil else newValue
end)

--[[
Output: {
[1] = 2,
[2] = 4,
[3] = 8,
[4] = 10
}
]]
```

<hr>

### collectSet

<span class="tags">
	[Tables](#tables)
</span>

```lua
type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?

collectSet<Key, Value, NewValue>(
	input: { [Key]: Value },
	handler: CollectHandler<Key, Value, NewValue>?
): Types.Set<Value | NewValue>
```

Build a set from the entries of the _input_ Table, calling _handler_ on each entry and using
the returned value as an element to add to the set.

If _handler_ is not provided, values of `input` are used as elements.

<hr>

**Examples**
```luau
-- Convert array to Set
Dash.collectSet({"toast", "bagel", "donut"})

--[[
Output: {
	["bagel"] = true,
	["donut"] = true,
	["toast"] = true
}
]]
```

```luau
-- Create set of first letters of each word
Dash.collectSet({"toast", "bagel", "donut", "bread"}, function(key, value)
	return value:sub(1, 1)
end)

--[[
Output: {
	["b"] = true,
	["d"] = true,
	["t"] = true
}
]]
```

### copy

<span class="tags">
	[Tables](#tables)
</span>

```lua
copy(input: Types.Table): Types.Table
```

Returns a shallow copy of the _input_ Table.

**Example**

```luau
Dash.copy({a = 1, b = 3})

--[[
Output: {
	["a"] = 1,
	["b"] = 3
}
]]
```
<hr>

### count

<span class="tags">
	[Tables](#tables)
</span>

```lua
type CountHandler<Key, Value> = (Value, Key) -> boolean

count<Key, Value>(input: { [Key]: Value }, handler: CountHandler<Key, Value>?): number
```

If no _handler_ is provided, return the number of elements in the _input_ [Table](#table).

If the _handler_ is provided, increase the count for each element for which the handler returns true on the `(value, key)` pair.

**Examples**

```luau
Dash.count({1, 2, 3, 4, 5}) --> 5
```

```luau
-- Count the number of ids that start with 1
Dash.count(
	{[12] = true, [24] = true, [153] = true, [199] = true},
	function(value, id) return tostring(id):sub(1, 1) == "1"
end)

--[[
Output: 3
]]
```

```luau
-- Count the number of numbers divisible by 5
Dash.count(
	{1, 1, 2, 3, 5, 8, 13, 21, 34, 55},
	function(num) return num % 5 == 0
end)

--[[
Output: 2
]]
```

<hr>

### filter

<span class="tags">
	[Tables](#tables)
</span>

```lua
type FilterHandler<Key, Value> = (Value, Key) -> boolean

filter<Key, Value>(input: { [Key]: Value }, handler: FilterHandler<Key, Value>): { Value }
```

Filter the _input_ [Table](#table) by calling the handler on each `(value, key)` tuple.

For an array input, the order of elements is preserved in the output.

The handler should return truthy to preserve the value in the resulting Table.

**Example**

```luau
-- Take only the elements whose values begin with "r"
Dash.filter(
	{place = "roblox", packages = "rotriever", ide = "studio"},
	function(word) return Dash.startsWith(word, "r")
end)

--[[
Output: {
	[1] = "roblox",
	[2] = "rotriever"
}
]]
```

<hr>

### find

<span class="tags">
	[Tables](#tables)
</span>

```lua
type FindHandler<Key, Value> = (Value, Key) -> boolean

find<Key, Value>(input: { [Key]: Value }, handler: FindHandler<Key, Value>): Value?
```

Returns an element in the _input_ [Table](#table) that the handler returns `true` for, when passed the
`(value, key)` entry.

Returns nil if no entries satisfy the condition.

For an array, this first matching element is returned.
For a Map, an arbitrary matching element is returned if it exists.

**Examples**

```luau
-- Check if there's the "ExtraSettings" key and get the value of that key if so
Dash.find(
	{Id = 145, IsReady = false, ExtraSettings = {AutoReady = true}},
	function(value, key) return key == "ExtraSettings" end
)

--[[
Output: {
	["AutoReady"] = true
}
]]


Dash.find({Id = 145, IsReady = false},
	function(value, key) return key == "ExtraSettings" end
)
--[[
Output: nil
]]

```

<hr>

### forEach

<span class="tags">
	[Tables](#tables)
</span>

```lua
type ForEachHandler<Key, Value> = (Value, Key) -> ()

forEach<Key, Value>(input: { [Key]: Value }, handler: ForEachHandler<Key, Value>)
```

Iterates through the elements of the _input_ Table.

If the table is an array, it iterates in order 1..n.

If the table is a Map, the keys are visited in an arbitrary order.

Calls the _handler_ for each entry.

**Example**
```luau
-- Print all values of a table
Dash.forEach({"Item 1", "Item 2", "Item 3" }, function(value) print(value) end)

--[[
Output: Item 1
Item 2
Item 3
]]
```

```luau
-- Print all values joined with keys
Dash.forEach({ a = "Item", b = "Item", c = "Item" }, function(value: string, key: string) print(value .. key) end)

--[[
Output: Item a
Item b
Item c
]]
```

<hr>

### frequencies

<span class="tags">
	[Tables](#tables)
</span>

```lua
type FrequenciesHandler<Key, Value, NewKey> = (Value, Key) -> NewKey

frequencies<Key, Value, NewKey>(
	input: { [Key]: Value },
	handler: FrequenciesHandler<Key, Value, NewKey>?
): { [NewKey | Value]: number }
```

If no handler is provided, returns a [Map](#map) with keys as unique values of the _input_ [Table](#table) and values as the count of each value.

If a handler is provided, returns a [Map](#map) with keys as unique elements given by the _handler_ and values as the count of each mapped key.

**Examples**

```luau
Dash.frequencies({"Red", "Black", "Orange", "Red"})

--[[
Output:{
	["Black"] = 1,
	["Orange"] = 1,
	["Red"] = 2
}
]]
```

```luau
-- Count colors by a simple definition of neutral and non-neutral
function toNeutral(color)
	return if Dash.includes({"Black", "Gray", "White"}, color)
		then "Neutral"
		else "Non-neutral"
end
Dash.frequencies(
	{"Black", "Orange", "Blue", "Gray", "White"},
	function(color) return toNeutral(color)
end)

--[[
Output: {
	["Neutral"] = 3,
	["Non-neutral"] = 2
}
]]
```

<hr>

### groupBy

<span class="tags">
	[Tables](#tables)
</span>

```lua
type GroupByHandler<Key, Value, GroupKey> = (Value, Key) -> GroupKey

groupBy<Key, Value, GroupKey>(
	input: { [Key]: Value },
	getKey: GroupByHandler<Key, Value, GroupKey> | GroupKey
): { [GroupKey]: { Value } }
```

Groups values in the _input_ [Table](#table) by their _getKey_ value.

Each value of the result [Table](#table) is an array of values from the _input_ [Table](#table) which were assigned
the corresponding key.

If _getKey_ is a function, it is called with each `(value, key)` entry and uses the return
value as the corresponding key to insert at in the result Table. Otherwise, the _getKey_ value
is used directly as the key itself.

**Example**

```luau
local output = groupBy({
	bike = {
		name = "bike",
		color = "blue"
	},
	car = {
		name = "car",
		color = "red"
	},
	van = {
		name = "van",
		color = "white"
	},
	ghost = {
		name = "ghost"
	}
}, "color")
--[[
Output: {
	blue = {
		{
			color = "blue",
			name = "bike"
		}
	},
	red = {
		{
			color = "red",
			name = "car"
		}
	},
	white = {
		{
			color = "white",
			name = "van"
		}
	}
}
]]
```

<hr>

### includes

<span class="tags">
	[Tables](#tables)
</span>

```lua
includes(source: Types.Table, value: any): boolean
```

Returns _true_ if the _item_ exists as a value in the _source_ [Table](#table).

**Example**
```luau
-- Does the table include 100?
Dash.includes({1, 10, 100, 1000}, 100)

--[[
Output: true
]]
```

**See**

For a stronger version of `Dash.includes`, use [Dash.some](#some).

<hr>

### keyBy

<span class="tags">
	[Tables](#tables)
</span>

```lua
type KeyByHandler<Key, Value, NewKey> = (Value, Key) -> NewKey

keyBy<Key, Value, NewKey>(input: { [Key]: Value }, getKey: KeyByHandler<Key, Value, NewKey> | NewKey): { [NewKey]: Value }
```

Assigns values in the _input_ [Table](#table) by their _getKey_ value.

If _getKey_ is a function, it is called with each `(value, key)` entry and uses the return
value as the corresponding key to assign to in the result Table. Otherwise, the _getKey_ value
is used directly as the key itself.

**Example**

```luau
local output = keyBy({
	bike = {
		name = "bike",
		color = "blue"
	},
	car = {
		name = "car",
		color = "red"
	},
	van = {
		name = "van",
		color = "white"
	},
	ghost = {
		name = "ghost"
	}
}, "color")

--[[
Output: {
	blue = {
		color = "blue",
		name = "bike"
	},
	red = {
		color = "red",
		name = "car"
	},
	white = {
		color = "white",
		name = "van"
	}
}
]]
```

<hr>

### keys

<span class="tags">
	[Tables](#tables)
</span>

```lua
keys<Key, Value>(input: { [Key]: Value }): { Key }
```

Returns an array of the keys in the _input_ Table.

If the input is an array, ordering is preserved.

If the input is a Map, elements are keys in an arbitrary order.

**Example**:
```luau
Dash.keys({
	Color = "Purple",
	Type = "Fruit",
	Shape = "Round"
})

--[[
Output: {
	[1] = "Color",
	[2] = "Type",
	[3] = "Shape"
}
]]
```

<hr>

### map

<span class="tags">
	[Tables](#tables)
</span>

```lua
type MapHandler<Key, Value, NewValue> = (Value, Key) -> NewValue

map<Key, Value, NewValue>(input: { [Key]: Value }, handler: MapHandler<Key, Value, NewValue>): { [Key]: NewValue }
```

Iterates through the elements of the _input_ Table.

For an array input, the elements are visited in order 1..n.

For a [Map](#map) input, the elements are visited in an arbitrary order.

Calls the _handler_ for each entry and constructs a new [Table](#table) using the same keys but replacing
the values with new ones returned from the handler.

Values returned by _handler_ must be defined.

**Example**
```luau
-- Map characters to their ASCII
Dash.map({"a", "b", "c"}, function(char) return string.byte(char) end)

--[[
Output: {
	[1] = 97,
	[2] = 98,
	[3] = 99
}
]]

-- Map values using their keys
Dash.map({ a = 1, b = 2, c = 3 }, function(value: number, key: string) return string.byte(key) + value end)

--[[
Output: {
	a = 98,
	b = 100,
	c = 102
}
]]
```

**See**

- [Dash.collectArray](#collectArray) if you want to return nil values.

<hr>

### mapOne

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
type MapHandler<Key, Value, NewValue> = (Value, Key) -> NewValue?

mapOne<Key, Value, NewValue>(input: { [Key]: Value }, handler: MapHandler<Key, Value, NewValue>?): NewValue?
```

Iterates through the elements of the _input_ [Table](#table) in no particular order.

Calls the _handler_ for each entry and returns the first non-nil value returned by the _handler_.
If all returned from the _handler_ values are `nil`, `nil` is returned.

If _handler_ is `nil`, the first value visited is returned.

**Example**

```luau
-- Get any message that's not hidden and return its id.
Dash.mapOne({
	{Id = 1, IsHidden = true},
	{Id = 3, IsHidden = false},
	{Id = 2, IsHidden = false},
}, function(message)
	return if message.IsHidden then nil else message.Id
end)

--[[
Output: 3
]]
```

<hr>

### max

<span class="tags">
	[Tables](#tables)
</span>

```lua
type MaxComparator = (any, any) -> boolean
type MaxHandler = (Value, Key) -> any

max(input: Types.Table, handler: MaxHandler?, comparator: MaxComparator): any
```

Returns the maximum value in the _input_ [Table](#table). By default, this returns the greatest value in the table as defined by the `>` operator.

If a _handler_ is provided, elements will first be transformed by `handler(value, key)` before being used for comparison.

Elements will be compared using the _comparator_ if it is provided. The comparator should take two elements and return `true` if the first one is greater than the second one, and `false` otherwise.

If the provided _input_ has no elements, return `nil`.

**Examples**

```luau
Dash.max({1, 2, 3}) --> 3
```

```luau
Dash.max({"1", "2", "10"}) --> "2"
```

```luau
Dash.max({1, 2, 3}, function(num) return -num end) --> 1
```

```luau
Dash.max(
	{"blue", "red", "orange"},
	nil,
	function(word1, word2) return word1:len() > word2:len() end
) --> "orange"
```

<hr>

### min

<span class="tags">
	[Table](#tables)
</span>

```lua
type MinComparator = (any, any) -> boolean
type MinHandler = (Value, Key) -> any

min(input: Types.Table, handler: MinHandler?, comparator: MinComparator): any
```

Returns the minimum value in the _input_ [Table](#table). By default, this returns the least value in the table as defined by the `<` operator.

If a _handler_ is provided, elements will first be transformed by `handler(value, key)` before being used for comparison.

Elements will be compared using the _comparator_ if it is provided. The comparator should take two elements and return `true` if the first one is less than the second one, and `false` otherwise.

If the provided _input_ has no elements, return `nil`.

**Examples**

```luau
Dash.min({1, 2, 3}) --> 1
```

```luau
Dash.min({"2", "20", "10"}) --> "10"
```

```luau
Dash.min({3, 2, 1}, function(num) return -num end) --> 3
```

```luau
Dash.min(
	{"blue", "red", "orange"},
	nil,
	function(word1, word2) return word1:len() < word2:len() end
) --> "red"
```

<hr>

### omit

<span class="tags">
	[Tables](#tables)
</span>

```lua
omit<Key, Value>(input: { [Key]: Value }, keys: { Key }): { [Key]: Value }
```

Return a new [Table](#table) made from entries in the _input_ [Table](#table) whose key is not in the _keys_ array.

If the input is an array, ordering is preserved.

If the input is a Map, elements are returned in an arbitrary order.

**Example**

```luau
-- Remove the ShouldShow key/value pair from the table
Dash.omit({
	ShouldShow = true,
	Text = "Hello World!",
	Title = "Greetings!",
}, {"ShouldShow"})

--[[
Output: {
	["Text"] = "Hello World!",
	["Title"] = "Greetings!"
}
]]
```

<hr>

### pick

<span class="tags">
	[Tables](#tables)
</span>

```lua
type PickHandler<Key, Value> = (Value, Key) -> boolean

pick<Key, Value>(input: { [Key]: Value }, handler: PickHandler<Key, Value>): { [Key]: Value }
```

Pick entries in the _input_ Table which should remain in the output by calling the handler on
each `(child, index)` tuple.

The handler should return truthy to preserve the value in the resulting Table.

**Examples**

```luau
Dash.pick(
	{10, 20, 30, 40, 50, 60},
	function(value, _) return value % 20 == 0 end
)

--[[
Output: {
	[2] = 20,
	[4] = 40,
	[6] = 60
}
]]
```

<hr>

### pipe

```lua
pipe<Args...>(f: (Args...) -> any, ...: (...any) -> any): (Args...) -> any
```

Creates a function that returns the result of passing a value through a pipeline of functions.
Each function in the pipeline receives the result of the previous function.
Functions are executed from left to right.

**Example**

```luau
local function addOne(n)
	return n + 1
end

local function double(n)
	return n * 2
end

local addThenDouble = pipe(addOne, double)
print(addThenDouble(2)) -- prints 6 ((2 + 1) * 2)
```

### reduce

<span class="tags">
	[Tables](#tables)
</span>

```lua
type ReduceHandler<Key, Value, Accumulator> = (Accumulator, Value, Key) -> Accumulator

reduce<Key, Value, Accumulator>(
	input: { [Key]: Value },
	handler: ReduceHandler<Key, Value, Accumulator>,
	initial: Accumulator
): Accumulator
```

Iterate through the elements of the _input_ [Table](#table), preserving order if it is an array.

Call the _handler_ for each element, passing the return of the previous call as the first argument.

The _initial_ value is passed into the first call, and the final value returned by the function.

**Examples**

```luau
-- Count occurrences of each element in array and output a table of counts
-- See Dash.frequencies
Dash.reduce(
	{"Red", "Black", "Red", "Red", "Black"},
	function(acc, color)
		if acc[color] == nil then
			acc[color] = 1
		else
			acc[color] += 1
		end
		return acc
	end, {}
)

--[[
Output: {
	["Black"] = 2,
	["Red"] = 3
}
]]
```

```luau
-- Sum up elements, doubling even indices and halving odd indices
-- Expected: 0.5 + 4 + 1.5 + 8 + 2.5 = 16.5
Dash.reduce(
	{1, 2, 3, 4, 5},
	function(acc, num, index)
		return acc + if index % 2 == 0 then num * 2 else num / 2
	end, 0
)
--[[
Output: 16.5
]]
```

<hr>

### shallowEqual

<span class="tags">
	[Tables](#tables)
</span>

```lua
shallowEqual(left: any, right: any): boolean
```

Returns `true` if the _left_ and _right_ values are equal (by the equality operator) or the
inputs are tables, and all their keys are equal.

**Examples**

```luau
Dash.shallowEqual({
	A = 1,
	B = 2
}, {
	A = 1,
	B = 2,
})

--[[
Output: true
]]
```

```luau
Dash.shallowEqual({
	A = 1,
	B = 2,
	C = 3
}, {
	A = 1,
	B = 2,
	D = 3
})

--[[
Output: false
]]
```

<hr>

### some

<span class="tags">
	[Tables](#tables)
</span>

```lua
type SomeHandler<Key, Value> = (Value, Key) -> boolean

some<Key, Value>(input: { [Key]: Value }, handler: SomeHandler<Key, Value>): boolean
```

Iterates through the elements of the _input_ [Table](#table) in no particular order.

Calls the _handler_ for each entry and returns `true` if the handler returns truthy for any
element which it is called with.

**Example**

```luau
-- Does there exist a red fruit?
Dash.some(
	{
		{Type = "Cherry", Color = "Red"},
		{Type = "Strawberry", Color = "Red"},
		{Type = "Blueberry", Color = "Blue"}
	},
	function(fruit) return fruit.Color == "Red" end
)

--[[
Output: true
]]
```

<hr>

### values

<span class="tags">
	[Tables](#tables)
</span>

```lua
values<Key, Value>(input: { [Key]: Value }): { Value }
```

Returns an array of the values in the _input_ Table.

If the input is an array, ordering is preserved.

If the input is a Map, values are returned in an arbitrary order.

**Example**
```luau
Dash.values({
	Type = "Cherry",
	Color = "Red",
	Price = "Expensive",
	EnjoymentLevel = "High"
})

--[[
Output: {
	[1] = "Red",
	[2] = "Cherry",
	[3] = "High",
	[4] = "Expensive"
}
]]
```

<hr>

## Arrays

These utilities operate on arrays, tables with ordered keys 1..n.

<hr>

### append

<span class="tags">
	[Mutable](#mutable) | [Arrays](#arrays)
</span>

```lua
append<T>(target: { T }, ...: { T }): { T }
```

Adds new elements to the _target_ array from subsequent array arguments in left-to-right order.

Arguments which are `nil` or None are skipped.

**Example**
```luau
Dash.append({1, 2}, {3, 4}, {5})

--[[
Output: {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5
}
]]
```

<hr>

### findIndex

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
type FindHandler<Value> = (Value, number) -> boolean

findIndex<Value>(input: { Value }, handler: FindHandler<Value>): number?
```

Returns the index of the first element in the _input_ array that the handler returns `true` for,
when passed the `(value, key)` entry.

Returns nil if no entries satisfy the condition.

**Examples**

```luau
-- Find index of "Clementine" fruit if it exists in the array
Dash.findIndex(
	{"Apple", "Banana", "Clementine"},
	function(fruit) return fruit == "Clementine" end
)

--[[
Output: 3
]]
```

```luau
Dash.findIndex(
	{"Apple", "Banana"},
	function(fruit) return fruit == "Clementine" end
)

--[[
Output: nil
]]
```

<hr>

### flat

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
flat(input: { any }): { any }
```

Flattens the input array by a single level.
Outputs a new array of elements merged from the _input_ array arguments in left-to-right order.

**Example**

```luau
-- Flatten a partition of numbers in the range 1-5
Dash.flat({
	{1, 2, 3},
	{4, 5}
})

--[[
Output:  {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5
}
]]
```

<hr>

### last

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
type FindHandler<Value> = (Value, number) -> boolean

last<Value>(input: { Value }, handler: FindHandler<Value>?): Value?
```

Returns the last element in the _input_ array that the handler returns `true` for, when
passed the `(value, key)` entry.

Returns nil if no entries satisfy the condition.

If handler is not defined, the function simply returns the last element of the array.

**Examples**

```luau
Dash.last({3, 2, 1})

--[[
Output: 1
]]
```

```luau
-- Get last odd number
Dash.last({4, 3, 2}, function(num) return num % 2 == 1 end)

--[[
Output: 3
]]
```

<hr>

### mapFirst

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
type MapHandler<Value, NewValue> = (Value, number) -> NewValue?

mapFirst<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
```

Iterates through the elements of the _input_ array in order 1..n.

Calls the _handler_ for each entry and returns the first non-nil value returned by the _handler_.
If all returned from the _handler_ values are `nil`, `nil` is returned.

**Example**

```luau
-- Get first color that's 6 letters and return its first letter
Dash.mapFirst(
	{"Red", "Yellow", "Orange", "Blue"},
	function(color)
		return if color:len() == 6 then color:sub(1, 1) else nil
	end
)

--[[
Output: Y
]]
```

<hr>

### mapLast

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
type MapHandler<Value, NewValue> = (Value, number) -> NewValue?

mapLast<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
```

Iterates through the elements of the _input_ array in reverse in order n..1.

Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.
If all returned from the _handler_ values are `nil`, `nil` is returned.

**Example**

```luau
-- Get last color that's 6 letters and return its first letter
Dash.mapLast(
	{"Red", "Yellow", "Orange", "Blue"},
	function(color)
		return if color:len() == 6 then color:sub(1, 1) else nil
	end
)

--[[
Output: O
]]
```

<hr>

### product

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
product(input: { number }): number
```

Multiplies together all the numbers in the _input_ array.

If the _input_ has no elements, return `1`.

**Example**
```luau
Dash.product({3, 3, 2}) --> 18
```

<hr>

### reverse

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
reverse<T>(input: { T }): { T }
```

Reverse the order of the elements in the _input_ array.

**Example**
```luau
Dash.reverse({3, 2, 1})

--[[
Output: {
	[1] = 1,
	[2] = 2,
	[3] = 3
}
]]
```

<hr>

### slice

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
slice<T>(input: { T }, left: number?, right: number?): { T }
```

Return a portion of the _input_ array starting with the element at the _left_ index and ending
with the element at the _right_ index (i.e. an inclusive range)

If _left_ is not defined, it defaults to 1.
If _right_ is not defined, it defaults to the length of the array (i.e. the last element)

If _left_ is `-n`, the slice starts with the element `n` places from the last one.
If _right_ is `-n`, the slice ends with the element `n` places from the last one.

An empty array is returned if the slice has no or negative length.

**Examples**
```luau
Dash.slice({1, 2, 3, 4, 5}, 2, 4)

--[[
Output: {
	[1] = 2,
	[2] = 3,
	[3] = 4
}
]]
```

```luau
Dash.slice({1, 2, 3, 4, 5}, 3)

--[[
Output: {
	[1] = 3,
	[2] = 4,
	[3] = 5
}
]]
```

```luau
Dash.slice({1, 2, 3, 4, 5}, nil, -1)

--[[
Output: {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4
}
]]
```

<hr>

### sum

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
sum(input: { number }): number
```

Adds together all the numbers in the _input_ array.

If the input array has no elements, return `0`.

**Example**
```luau
Dash.sum({3, 2, 1}) --> 6
```

<hr>

## Maps

These utilities operate on [Maps](#map), tables with arbitrary keys.

<hr>

### assign

<span class="tags">
	[Mutable](#mutable) | [Maps](#maps)
</span>

```lua
assign<Key, Value>(target: Types.Map<Key, Value>, ...: Types.Map<Key, Value>): Types.Map<Key, Value>
```

Adds new values to _target_ from subsequent [Table](#table) arguments in left-to-right order.

**Examples**

```luau
local characters = {
	Frodo = {
		name = "Frodo Baggins",
		team = "blue"
	},
	Boromir = {
		score = 5
	}
}
local otherCharacters = {
	Frodo = {
		team = "red",
		score = 10
	},
	Bilbo = {
		team = "yellow",
	},
	Boromir = {
		score = {1, 2, 3}
	}
}
local result = assign(characters, otherCharacters)
print(result) --[[
--> {
	Frodo = {
		team = "red",
		score = 10
	},
	Bilbo = {
		team = "yellow"
	},
	Boromir = {
		score = {1, 2, 3}
	}
}
]]
```

**See**

- [Dash.join](#join) for an immutable alternative

<hr>

### freeze

<span class="tags">
	[Maps](#maps)
</span>

```lua
freeze(objectName: string, object: Types.Table, throwIfMissing: boolean?): Types.Table
```

Returns a new read-only view of _object_ which prevents any values from being changed.

**Parameters**

| Name             | Description                                                    |
|------------------|----------------------------------------------------------------|
| `name`           | The name of the object for improved error message readability. |
| `throwIfMissing` | If `true` then access to a missing key will also throw.        |

**Notes**

Unfortunately you cannot iterate using `pairs` or `ipairs` on frozen objects because Luau doesn't support defining these custom iterators in metatables.

**Example**

```luau
local drink = freeze("Ice Cream", {
	flavor = "mint",
	topping = "sprinkles"
}, true)
print(drink.flavor) --> "mint"
drink.flavor = "vanilla"
--!> ReadonlyKey: Attempt to write to readonly key "flavor" (a string) of frozen object "Ice Cream"
print(drink.syrup) --> nil
--!> MissingKey: Attempt to read missing key "syrup" (a string) of frozen object "Ice Cream"
```

<hr>

### get

<span class="tags">
	[Tables](#tables)
</span>

```lua
get<T>(object: { [any]: any }, path: { any }, defaultValue: T?): T?
```

Gets the value at path of object. If the resolved value is nil, the defaultValue is returned in its place.

The path should be an array of keys (e.g. `{ "a", "b", "c" }`, `{ "test", "test.test", 0 }`).

**Examples**

```luau
local object = {
    a = {
        b = {
            c = 3
        }
    }
}
Dash.get(object, { "a", "b", "c" }) --> 3
Dash.get(object, { "x", "y", "z" }, "default") --> "default"
```

```luau
-- Array indexing
local object = {
    items = {
        { name = "first" },
        { name = "second" }
    }
}
Dash.get(object, { "items", 1, "name" }) --> "first"
```

```luau
-- Keys with dots
local object = {
    test = {
        ["test.test"] = {
            [0] = "value"
        }
    }
}
Dash.get(object, { "test", "test.test", 0 }) --> "value"
```

**See**
- [Dash.getOrSet](#getOrSet) - for getting a value with a default generator function

<hr>

### getOrSet

<span class="tags">
	[Maps](#maps)
</span>

```lua
type GetValueHandler<Key, Value> = ({ [Key]: Value }, Key) -> Value

getOrSet<Key, Value>(input: { [Key]: Value }, key: Key, getValue: GetValueHandler<Key, Value>): Value
```

Returns a value of the _input_ [Table](#table) at the _key_ provided.
If the key is missing, the value is acquired from the _getValue_ handler,
added to the _input_ [Table](#table) and returned.

**Examples**

```luau
Dash.getOrSet(
	{Item = "Gummy Bear", Color = "Lime"},
	"Color",
	function() return "Yellow" end
)

--[[
Output: Lime
]]
```

```luau
Dash.getOrSet(
	{Item = "Gummy Bear"},
	"Color",
	function() return "Yellow" end
)

--[[
Output: Yellow
]]
```

<hr>

### join

<span class="tags">
	[Maps](#maps)
</span>

```lua
join<Key, Value>(...: Types.Map<Key, Value>): Types.Map<Key, Value>
```

Output a new [Map](#map) from merging all the keys in the [Map](#map) arguments in left-to-right order.

**Example**
```luau
Dash.join(
	{Text = "Hello World!", Color = "Sky Blue"},
	{Title = "Greetings!", Color = "Indigo"}
)

--[[
Output: {
	["Color"] = "Indigo",
	["Text"] = "Hello World!",
	["Title"] = "Greetings!"
}
]]
```

**See**

- [Dash.assign](#assign) for a mutable alternative

<hr>

### joinDeep

<span class="tags">
	[Maps](#maps)
</span>

```lua
joinDeep(source: Types.Map<any, any>, delta: Types.Map<any, any>): Types.Map<any, any>
```

Creates a shallow clone of the _source_ Map and copies the values from the _delta_ Map
by key, like the join utility.

However, if any of the values are tables themselves, the joinDeep function is called
recursively to produce a new table at the specified key.

The purpose of this function is to merge nested immutable data using as few table
creation operations as possible, making it appropriate for updating state in a reducer.

**Usage**

- The [None](#none) symbol can be used to remove an existing value.

**Example**

```luau
local source = {
	name = "car",
	lights = {
		front = 2,
		back = 2,
		indicators = {
			color = "orange"
		},
		brake = {
			color = "red"
		}
	},
	tyres = 4
}
local delta = {
	name = "bike",
	lights = {
		front = 3,
		indicators = {
			rate = 20
		}
	},
	tyres = None
}
local output = joinDeep(source, delta)
[[
Output: {
	lights = {
		back = 2,
		brake = {
			color = "red"
		},
		front = 3,
		indicators = {
			color = "orange",
			rate = 20
		}
	},
	name = "bike"
}
]]
```

<hr>

## Strings

<hr>

These utilities are helpful for working with strings.

<hr>

### endsWith

<span class="tags">
	[Strings](#strings)
</span>

```lua
endsWith(input: string, suffix: string): boolean
```

Checks if _input_ ends with the string _suffix_.

**Examples**

```luau
endsWith("Fun Roblox Games", "Games") --> true
```

```luau
endsWith("Bad Roblox Memes", "Games") --> false
```

<hr>

### isLowercase

<span class="tags">
	[Strings](#strings)
</span>

```lua
isLowercase(input: string): boolean
```

Returns `true` if the first character of _input_ is a lower-case character.

Throws if the _input_ is not a string or it is the empty string.

Our current version of Lua unfortunately does not support upper or lower-case detection outside
the English alphabet. This function has been implemented to return the expected result once
this has been corrected.

**Examples**

```luau
Dash.isLowercase("abcdef") --> true
```

```luau
Dash.isLowercase("Title") --> false
```

<hr>

### isUppercase

<span class="tags">
	[Strings](#strings)
</span>

```lua
isUppercase(input: string): boolean
```

Returns `true` if the first character of _input_ is an upper-case character.

Throws if the _input_ is not a string or it is the empty string.

Our current version of Lua unfortunately does not support upper or lower-case detection outside
the English alphabet. This function has been implemented to return the expected result once
this has been corrected.

**Examples**

```luau
Dash.isUppercase("ABCDEF") --> true
```

```luau
Dash.isUppercase("rObLoX") --> false
```

<hr>

### leftPad

<span class="tags">
	[Strings](#strings)
</span>

```lua
leftPad(input: string, length: number, prefix: string?): string
```

Makes a string of `length` from `input` by repeating characters from `prefix` at the start of the string.

**Params**

- `prefix` - default = `""`

**Examples**

```luau
leftPad("toast", 6) --> " toast"
```

```luau
leftPad("2", 2, "0") --> "02"
```

```luau
leftPad("toast", 10, ":)") --> ":):):toast"
```

<hr>

### rightPad

<span class="tags">
	[Strings](#strings)
</span>

```lua
rightPad(input: string, length: number, suffix: string?): string
```

Makes a string of `length` from `input` by repeating characters from `suffix` at the end of the string.

By default, suffix is `" "`.

**Examples**

```luau
rightPad("toast", 6) --> "toast "
```

```luau
rightPad("2", 2, "!") --> "2!"
```

```luau
rightPad("toast", 10, ":)") --> "toast:):):"
```

<hr>

### splitOn

<span class="tags">
	[Strings](#strings)
</span>

```lua
splitOn(input: string, pattern: string): { string }
```

Splits _input_ into parts based on a _pattern_ delimiter and returns a [Table](#table) of the parts,
followed by a [Table](#table) of the matched delimiters.

**Example**

```luau
local parts, delimiters = Dash.splitOn(
	"The quick brown fox jumps over the lazy dog",
	" "
)

print(parts)
--[[
Output: {
	[1] = "The",
	[2] = "quick",
	[3] = "brown",
	[4] = "fox",
	[5] = "jumps",
	[6] = "over",
	[7] = "the",
	[8] = "lazy",
	[9] = "dog"
}
]]

print(delimiters)
--[[
{
	[1] = " ",
	[2] = " ",
	[3] = " ",
	[4] = " ",
	[5] = " ",
	[6] = " ",
	[7] = " ",
	[8] = " "
}
]]
```

<hr>

### startsWith

<span class="tags">
	[Strings](#strings)
</span>

```lua
startsWith(input: string, prefix: string): boolean
```

Checks if _input_ starts with the string _start_.

**Examples**

```luau
startsWith("Fun Roblox Games", "Fun") --> true
```

```luau
startsWith("Chess", "Fun") --> false
```

<hr>

### trim

<span class="tags">
	[Strings](#strings)
</span>

```lua
trim(input: string): string
```

Remove any whitespace at the start and end of the _input_ string.

**Example**
```luau
Dash.trim("\n\t\rhello world   ") --> "hello world"
```

<hr>

## Functions

These utilities are helpful for working with functions.

<hr>

### memoize

<span class="tags">
	[Functions](#functions)
</span>

```lua
type ResolverFunction = (...any) -> string

memoize(func: Types.AnyFunction, resolver: ResolverFunction?): Types.AnyFunction
```

Creates a function that memoizes the result of `func`. The memoized function will cache results based on the arguments provided. If a resolver function is provided, it will be used to generate the cache key from the arguments.

**Examples**

```luau
local function add(a, b)
    return a + b
end

local memoizedAdd = memoize(add)
print(memoizedAdd(1, 2)) -- Calculates and caches: 3
print(memoizedAdd(1, 2)) -- Returns from cache: 3

-- With custom resolver
local memoizedWithResolver = memoize(add, function(a, b)
    return string.format("%d_%d", a, b)
end)
```

**Usage**

- Use memoization for expensive computations that are called frequently with the same arguments
- The resolver function can be used to customize how arguments are used to generate cache keys
- Be mindful of memory usage as cached results are stored indefinitely

<hr>

### forEachArgs

<span class="tags">
	[Functions](#functions)
</span>

```lua
forEachArgs(handler: Types.AnyFunction, ...: Value): ()
```

Iterates through the tail arguments in order, including nil values up to the argument list length.

Calls the _handler_ for each entry.

<hr>

### identity

<span class="tags">
	[Functions](#functions)
</span>

```luau
identity(...)
```

The identity function, which simply returns its input parameters.

Can be used to make it clear that a handler returns its inputs.

<hr>

### isCallable

<span class="tags">
	[Functions](#functions)
</span>

```lua
isCallable<T>(value: T): boolean
```

Returns `true` if the value can be called i.e. you can write `value(...)`.

<hr>

### noop

<span class="tags">
	[Functions](#functions)
</span>

```luau
noop()
```

A function which does nothing.

Can be used to make it clear that a handler has no function.

<hr>

### chain

<span class="tags">
	[Functions](#functions)
</span>

```luau
chain(("test"):gmatch("t"), ("test"):gmatch("e"))
```

Returns a stateful iterator that returns elements from the first iterable until it is exhausted,
then proceeds to the next iterator until all the iterators are exhausted.

<hr>

### debounce

<span class="tags">
	[Functions](#functions)
</span>

```luau
-- Numeric delay: trailing by default
local debouncedGreeting = debounce(function(name: string)
	print(`Hi, {name}!`)
end, 0.3)
debouncedGreeting("Hugh")

-- Options as third arg: leading/trailing toggles; wait stays second arg
local debouncedLeading = debounce(function(v)
	print("Leading", v)
end, 0.2, { leading = true, trailing = false })

local debouncedTrailing = debounce(function(v)
	print("Trailing", v)
end, 0.2, { leading = false, trailing = true })
```

Creates and returns a new debounced version of the passed function which will postpone its execution
until after `wait` seconds have elapsed since the last time it was invoked.

Defaults: leading = false, trailing = true.

<hr>

### throttle

<span class="tags">
	[Functions](#functions)
</span>

```luau
-- Numeric delay: immediate then trailing with latest args
local throttledGreeting = throttle(function(name: string) print(`Hi, {name}!`) end, 0.3)
throttledGreeting("Hugh")

-- Options as third arg: configure leading/trailing; wait stays second arg
local throttledLeadingOnly = throttle(function(v)
	print("Leading", v)
end, 0.2, { leading = true, trailing = false })

local throttledTrailingOnly = throttle(function(v)
	print("Trailing", v)
end, 0.2, { leading = false, trailing = true })
```

Creates and returns a new throttled version of the passed function which will ensure that the function
is called at most once during the specified wait period. If called multiple times during the wait period,
only the first call will be executed immediately, and subsequent calls will be ignored until the wait period has elapsed.

- Leading=true triggers immediately when outside the throttle window.
- Trailing=true schedules a single call at the end of the window with the latest args.

The last call will always be done after the same delay. e.g.
```luau
local throttled = throttle(function(v) print(v) end, 0.1)
for i = 1, 10 do
    throttled(i)
end
```
would result in
```
1
10
```

`throttle` is useful for preventing a function from being called too often, e.g. when reacting to resize events.

## Classes

These utilities are helpful for working with classes.

<hr>

### Error

<span class="tags">
	[Classes](#classes)
</span>

```lua
Error.new(name: string, message: string, tags: Table?)
```

Create an error object with a specified name and message.

In native Lua, errors can only be string values. At Roblox, we can take advantage of throwing
error objects to provide structured information about problems that occur.

The tags table stores rich information about an error which can be provided when it is
thrown and later passed to a logging endpoint.

Throwing an error instance captures its stack trace, avoiding the need to explicitly use xpcall.

**Fields**

| Name              | Description                                                                          |
|-------------------|--------------------------------------------------------------------------------------|
| `name: string`    | The name of the error                                                                |
| `message: string` | A message which will be formatted with [Dash.format](#format) if the error is thrown |
| `tags: Table`     | A table to store custom rich information about the error                             |
| `stack: string?`  | The value of `debug.traceback()` when the error is thrown                            |

**Methods**

| Name                      | Description                                                                                                                                                                 |
|---------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `:joinTags(tags: Table?)` | Return a new error instance containing the tags provided joined to any existing tags of the current error instance.                                                         |
| `:throw(tags: Table?)`    | Throw an error.<br><br>The stack of the error is captured and stored.<br><br>If tags are provided, a new error is created and thrown with the joined tags of this instance. |

**Static Methods**

| Name                                                | Description                                      |
|-----------------------------------------------------|--------------------------------------------------|
| `.new(name: string, message: string, tags: Table?)` | Returns a new `Error` instance                   |
| `.is(other: any)`                                   | Returns `true` if _other_ is an `Error` instance |

**Usage**

In general, errors should not be used during normal control flow.

<hr>

### Symbol

<span class="tags">
	[Classes](#classes)
</span>

Create a symbol with a specified name. Upper snake-case is recommended as the symbol is a
constant, unless you are linking the symbol conceptually to a different string.

Symbols are useful when you want a value that isn't equal to any other type, for example, if you
want to store a unique property on an object that won't be accidentally accessed with a simple
string lookup.

**Static Methods**

| Name                 | Description                                               |
|----------------------|-----------------------------------------------------------|
| `.new(name: string)` | Returns a new unique `Symbol` instance with called _name_ |
| `.is(other: any)`    | Returns `true` if _other_ is a `Symbol` instance          |

**Example**

```luau
local CHEESE = Symbol.new("CHEESE")
local FAKE_CHEESE = Symbol.new("CHEESE")
print(CHEESE == CHEESE) --> true
print(CHEESE == FAKE_CHEESE) --> false
print(tostring(CHEESE)) --> "Symbol.new(CHEESE)"
```

<hr>

### class

<span class="tags">
	[Classes](#classes)
</span>

Create a class called _name_ with the specified _constructor_. The constructor should return a
plain table which will be turned into an instance of _Class_ from a call to `Class.new(...)`.

**Instance Methods**

| Name                          | Description                                                               |
|-------------------------------|---------------------------------------------------------------------------|
| `:toString(): string`         | Returns a string representation of the class                              |
| `:equals(other: any):boolean` | Returns `true` if the instance is equal to _other_                        |
| `:_init()`                    | A private function which is called once the instance has been initialized |

**Static Methods**

| Name                               | Description                                           |
|------------------------------------|-------------------------------------------------------|
| `.new(...): Table`                 | Returns a new instance of the class                   |
| `.isInstance(value: any): boolean` | Returns `true` if _value_ is an instance of the class |

**Examples**

```luau
-- Create a simple Vehicle class
local Vehicle = class("Vehicle", function(wheelCount: number) return
	{
		speed = 0,
		wheelCount = wheelCount
	}
end)
function Vehicle:drive(speed)
	self.speed = speed
end
-- Create a car instance
local car = Vehicle.new(4)
-- car.wheelCount --> 4
-- car.speed --> 0
-- Drive the car
car:drive(10)
-- car.speed --> 10
```

**Usage**

- When using Dash classes, private fields should be prefixed with `_` to avoid accidental access.
- A private field should only be accessed by a method of the class itself, though Dash does not restrict this in code.
- Public fields are recommended when there is no complex access logic e.g. `position.x`

<hr>

## Symbols

Symbol definitions.

<hr>

### None

<span class="tags">
	[Symbols](#symbols)
</span>

A symbol representing nothing, that can be used in place of nil as a key or value of a table,
where nil is illegal.

Utility functions can check for the None symbol and treat it like a nil value.

**Usage**

Use cases include:

1. Creating an ordered list with undefined values in it
2. Creating a map with a key pointing to a nil value

<hr>

## Debugging

These utilities assist with debugging Lua code.

### assertEqual

<span class="tags">
	[Debugging](#mutable) | [Maps](#maps)
</span>

```lua
assertEqual(left: any, right: any, formattedErrorMessage: string?): ()
```

Performs a simple equality check and throws an error if _left_ is not equal to _right_.

The formatted error message can be customized, which by default provides serialization of
both inputs using [Dash.pretty](#pretty).

The `left` and `right` values are available to be referenced in the formatted message.

<hr>

### cycles

<span class="tags">
	[Debugging](#debugging) | [Tables](#tables)
</span>

```lua
cycles(value: any, initialCycles: Cycles?): Cycles
```

Get information about the number of times references to the same table values appear in a data structure.

Operates on cyclic structures, and returns a Cycles object for a given _value_ by walking it recursively.

**Cycles**

| Name      | Type                 | Description                                         |
|-----------|----------------------|-----------------------------------------------------|
| `omit`    | `{ any }`            | An array of keys which should not be visited        |
| `visited` | `Set<Table>`         | A set of tables which were visited recursively      |
| `refs`    | `Map<Table, number>` | A map from table to unique index in visit order     |
| `nextRef` | `number`             | The number to use for the next unique table visited |

<hr>

### format

<span class="tags">
	[Debugging](#debugging) | [Strings](#strings)
</span>

```lua
format(formatString: string, ...): string
```

Returns the _format_ string with placeholders `{...}` substituted with readable representations
of the subsequent arguments.
This function is a simpler & more powerful version of `string.format`, inspired by `format!`
in Rust.

- `{}` formats and prints the next argument using `:format()` if available, or a suitable
  default representation depending on its type.
- `{blah}` formats and prints the key "blah" of the 1st argument
- `{2}` formats and prints the 2nd argument.
- `{#2}` prints the length of the 2nd argument.
  Display parameters can be combined after a `:` in the curly braces. Any format parameters used
  in `string.format` can be used here, along with these extras:
- `{:?}` formats any value using `pretty`.
- `{:#?}` formats any value using multiline `pretty`.

  **Examples**

```luau
local props = {"teeth", "claws", "whiskers", "tail"}
format("{} is in {:#?}", "whiskers", props)
--> [[whiskers is in {"teeth", "claws", "whiskers", "tail"}]]
```

```luau
format("The time is {:02}:{:02}", 2, 4) --> "The time is 02:04"
```

```luau
format("The color blue is #{:06X}", 255) --> "The color blue is #0000FF"
```

**Usage**

- Escape `{` with `{{` and `}` similarly with `}}`.
- See [https://developer.roblox.com/articles/Format-String](https://developer.roblox.com/articles/Format-String) for a complete list of formating options and further use cases.

<hr>

### formatValue

<span class="tags">
	[Debugging](#debugging) | [Strings](#strings)
</span>

```lua
formatValue(value: any, displayString: string): string
```

Format a specific _value_ using the specified _displayString_.

**Examples**

```luau
formatValue(255, "06X") --> "0000FF"
```

```luau
formatValue(255.5) --> "255.5"
```

**See**

- [Dash.format](#format) - see format for a full description of valid display strings.

<hr>

### pretty

<span class="tags">
	[Debugging](#debugging) | [Tables](#tables) | [Strings](#strings)
</span>

```lua
pretty(object: any, options: PrettyOptions?): string
```

Return a pretty string serialization of _object_.

This implementation deals with cycles in tables and can neatly display metatables.

Optionally use an indented multiline string, limit the depth of tables, omit or pick keys.

**PrettyOptions**

| Name        | Type          | Description                                                                                 |
|-------------|---------------|---------------------------------------------------------------------------------------------|
| `depth`     | `number?`     | The maximum depth of ancestors of a table to display                                        |
| `omit`      | `{ any }?`    | An array of keys which should not be visited                                                |
| `multiline` | `boolean?`    | Whether to use multiple lines (default = false)                                             |
| `noQuotes`  | `boolean?`    | Whether to drop the quotation marks around strings. By default, this is true for table keys |
| `indent`    | `string?`     | The indent string to use (default = "\t")                                                   |
| `visited`   | `Set<Table>?` | A set of tables which have already been visited and should be referred to by reference      |
| `cycles`    | `Cycles?`     | A cycles object returned from `cycles` to aid reference display                             |

**See**

- [Dash.cycles](#cycles)

<hr>
