# API Reference

## Types

### Array

```lua
type Array<Value> = {[number]: Value}
```

A table with values of type _Value_ and numeric keys 1..n with no gaps

<hr>

### Args

```lua
type Args<Value> = {[number]: Value}
```

A table with values of type _Value_ and numeric keys, possibly with gaps.

<hr>

### Map

```lua
Map<Key, Value> = {[Key]: Value}
```

A table with keys of type _Key_ and values of type _Value_

<hr>

### Set

```lua
type Set<Key> = {[Key]: boolean}
```

A table with keys of a fixed type _Key_ and a boolean value representing membership of the set (default is false)

<hr>

### Table

```lua
type Table = {[any]: any}
```

A table of any type

<hr>

### Class

```lua
type Class<Object> = {

new: () -> Object
}
```

A class has a constructor returning an instance of _Object_ type

<hr>

### Handler

```lua
type Handler<Value> = (Value, number) -> ()
```

A callback function for an `ipairs` iteration which is called with a value and index.

<hr>

### PairsHandler

```lua
type PairsHandler<Key, Value> = (Value, Key) -> ()
```

A callback function for a `pairs` iteration which is called with a value and key.

<hr>

## Tables

These utilities operate on [Tables](#table) of any kind.

<hr>

### collect

<span class="tags">
	[Tables](#tables)
</span>

```lua
collect(input: Types.Table, handler: CollectHandler): Types.Map<any, any>
```

Collect returns a new [Table](#table) derived from _input_ by iterating through its pairs and calling
the handler on each `(key, child)` tuple.

The handler should return a new `(newKey, value)` tuple to be inserted into the returned Table,
or `nil` if no value should be added.

<hr>

### collectArray

<span class="tags">
	[Tables](#tables)
</span>

```lua
collectArray(input: Types.Table, handler: Types.AnyFunction)
```

Collect returns a new [Array](#array) derived from _input_ by iterating through its pairs and calling
the handler on each `(key, child)` tuple.

The handler should return a new value to be pushed onto the end of the result array, or `nil`
if no value should be added.

<hr>

### collectSet

<span class="tags">
	[Tables](#tables)
</span>

```lua
collectSet(input: Types.Table, handler: Types.AnyFunction?)
```

Build a set from the entries of the _input_ Table, calling _handler_ on each entry and using
the returned value as an element to add to the set.

If _handler_ is not provided, values of `input` are used as elements.

<hr>

### copy

<span class="tags">
	[Tables](#tables)
</span>

```lua
copy(input: Types.Table): Types.Table
```

Returns a shallow copy of the _input_ Table.

<hr>

### filter

<span class="tags">
	[Tables](#tables)
</span>

```lua
filter(input: Types.Table, handler: FilterHandler): Types.Array<any>
```

Filter the _input_ [Table](#table) by calling the handler on each `(child, index)` tuple.

For an [Array](#array) input, the order of elements is prevered in the output.

The handler should return truthy to preserve the value in the resulting Table.

<hr>

### find

<span class="tags">
	[Tables](#tables)
</span>

```lua
find(input: Types.Table, handler: FindHandler)
```

Returns an element in the _input_ [Table](#table) that the handler returns `true` for, when passed the
`(child, key)` entry.

Returns nil if no entires satisfy the condition.

For an Array, this first matching element is returned.
For a Map, an arbitrary matching element is returned if it exists.

**See**

- [Dash.first](#first) for a function which returns the first element of an [Array](#array) matching a condition.

<hr>

### forEach

<span class="tags">
	[Tables](#tables)
</span>

```lua
forEach(input: Types.Table, handler: Handler<Value>): ()
```

Iterates through the elements of the _input_ Table.

If the table is an Array, it iterates in order 1..n.

If the table is a Map, the keys are visited in an arbitrary order.

Calls the _handler_ for each entry.

<hr>

### groupBy

<span class="tags">
	[Tables](#tables)
</span>

```lua
groupBy(input: Dash.Table, getKey: any)
```

Groups values in the _input_ [Table](#table) by their _getKey_ value.

Each value of the result [Table](#table) is an [Array](#array) of values from the _input_ [Table](#table) which were assigned
the corresponding key.

If _getKey_ is a function, it is called with each `(child, key)` entry and uses the return
value as the corresponding key to insert at in the result Table. Otherwise, the _getKey_ value
is used directly as the key itself.

**Example**

```lua
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

<hr>

### keyBy

<span class="tags">
	[Tables](#tables)
</span>

```lua
keyBy(input: Types.Table, getKey: any): Types.Table
```

Assigns values in the _input_ [Table](#table) by their _getKey_ value.

If _getKey_ is a function, it is called with each `(child, key)` entry and uses the return
value as the corresponding key to assign to in the result Table. Otherwise, the _getKey_ value
is used directly as the key itself.

**Example**

```lua
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
[[
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
}]]
```

<hr>

### keys

<span class="tags">
	[Tables](#tables)
</span>

```lua
keys(input: Types.Table): Types.Array<any>
```

Returns an [Array](#array) of the keys in the _input_ Table.

If the input is an Array, ordering is preserved.

If the input is a Map, elements are keys in an arbitrary order.

<hr>

### map

<span class="tags">
	[Tables](#tables)
</span>

```lua
map(input: Types.Table, handler: MapHandler): Types.Table
```

Iterates through the elements of the _input_ Table.

For an [Array](#array) input, the elements are visted in order 1..n.

For a [Map](#map) input, the elements are visited in an arbitrary order.

Calls the _handler_ for each entry and constructs a new [Table](#table) using the same keys but replacing
the values with new ones returned from the handler.

Values returned by _handler_ must be defined.

**See**

- [Dash.collectArray](#collectArray) if you want to return nil values.

<hr>

### mapOne

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
mapOne(input: Types.Table, handler: MapHandler?)
```

Iterates through the elements of the _input_ [Table](#table) in no particular order.

Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.

If _handler_ is `nil`, the first value visited is returned.

<hr>

### omit

<span class="tags">
	[Tables](#tables)
</span>

```lua
omit(input: Types.Table, keys: Types.Array<any>): Types.Table
```

Return a new [Table](#table) made from entries in the _input_ [Table](#table) whose key is not in the _keys_ Array.

If the input is an Array, ordering is preserved.

If the input is a Map, elements are returned in an arbitrary order.

<hr>

### shallowEqual

<span class="tags">
	[Tables](#tables)
</span>

```lua
shallowEqual(left: any, right: any)
```

Returns `true` if the _left_ and _right_ values are equal (by the equality operator) or the
inputs are tables, and all their keys are equal.

<hr>

## Arrays

These utilities operate on [Arrays](#array), tables with ordered keys 1..n.

<hr>

### append

<span class="tags">
	[Mutable](#mutable) | [Arrays](#arrays)
</span>

```lua
append<T>(target: Types.Array<T>, ...: Types.Array<T>): Types.Array<T>
```

Adds new elements to the _target_ [Array](#array) from subsequent [Array](#array) arguments in left-to-right order.

Arguments which are `nil` or None are skipped.

<hr>

### findIndex

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
findIndex(input: Types.Array<any>, handler: FindHandler)
```

Returns the index of the first element in the _input_ [Array](#array) that the handler returns `true` for,
when passed the `(child, key)` entry.

Returns nil if no entires satisfy the condition.

<hr>

### flat

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
flat(input: Types.Array<Types.Array<any>>): Types.Array<any>
```

Flattens the input array by a single level.
Outputs a new [Array](#array) of elements merged from the _input_ [Array](#array) arguments in left-to-right order.

<hr>

### last

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
last(input: Types.Table): Types.Array<any>
```

Returns the last element in the _input_ [Array](#array) that the handler returns `true` for, when
passed the `(child, index)` entry.

Returns nil if no entires satisfy the condition.

If handler is not defined, the function simply returns the last element of the Array.

<hr>

### mapFirst

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
mapFirst(input: Types.Array<any>, handler: MapHandler)
```

Iterates through the elements of the _input_ [Array](#array) in order 1..n.

Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.

<hr>

### mapLast

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
mapLast(input: Types.Array<any>, handler: MapHandler)
```

Iterates through the elements of the _input_ [Array](#array) in reverse in order n..1.

Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.

<hr>

### reduce

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
reduce(input: Types.Array<any>, handler: ReduceHandler, initial: any)
```

Iterate through the elements of the _input_ [Array](#array) in order 1..n.

Call the _handler_ for each element, passing the return of the previous call as the first argument.

The _initial_ value is passed into the first call, and the final value returned by the function.

<hr>

### reverse

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
reverse(input: Types.Array<any>): Types.Array<any>
```

Reverse the order of the elements in the _input_ Array.

<hr>

### slice

<span class="tags">
	[Arrays](#arrays)
</span>

```lua
slice(input: Types.Array<any>, left: number?, right: number?)
```

Return a portion of the _input_ [Array](#array) starting with the element at the _left_ index and ending
with the element at the _right_ index (i.e. an inclusive range)

If _left_ is not defined, it defaults to 1.
If _right_ is not defined, it defaults to the length of the array (i.e. the last element)

If _left_ is `-n`, the slice starts with the element `n` places from the last one.
If _right_ is `-n`, the slice ends with the element `n` places from the last one.

An empty array is returned if the slice has no or negative length.

<hr>

## Maps

These utilities operate on [Maps](#map), tables with arbitrary keys.

<hr>

### assign

<span class="tags">
	[Mutable](#mutable) | [Maps](#maps)
</span>

```lua
assign(target: Table, ...: Args<Table>): Table
```

Adds new values to _target_ from subsequent [Table](#table) arguments in left-to-right order.

**Examples**

```lua
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
freeze(objectName: string, object: Table, throwIfMissing: boolean?): Table
```

Returns a new read-only view of _object_ which prevents any values from being changed.

**Parameters**

| Name             | Description                                                    |
| ---------------- | -------------------------------------------------------------- |
| `name`           | The name of the object for improved error message readability. |
| `throwIfMissing` | If `true` then access to a missing key will also throw.        |

**Notes**

Unfortunately you cannot iterate using `pairs` or `ipairs` on frozen objects because Luau doesn't support defining these custom iterators in metatables.

**Example**

```lua
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

### getOrSet

<span class="tags">
	[Maps](#maps)
</span>

```lua
getOrSet(input: Types.Table, key: any, getValue: GetValueHandler)
```

Returns a value of the _input_ [Table](#table) at the _key_ provided.
If the key is missing, the value is acquired from the _getValue_ handler,
added to the _input_ [Table](#table) and returned.

<hr>

### join

<span class="tags">
	[Maps](#maps)
</span>

```lua
join(...): Types.Map<any, any>
```

Output a new [Map](#map) from merging all the keys in the [Map](#map) arguments in left-to-right order.

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

Creates a shallow clone of the _source_ Map, and copies the values from the _delta_ Map
by key, like the join utility.

However, if any of the values are tables themselves, the joinDeep function is called
recursively to produce a new table at the specified key.

The purpose of this function is to merge nested immutable data using as few table
creation operations as possible, making it appropriate for updating state in a reducer.

**Usage**

- The [None](#none) symbol can be used to remove an existing value.

**Example**

```lua
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

### some

<span class="tags">
	[Maps](#maps)
</span>

```lua
some(input: Types.Map<any, any>, handler: SomeHandler?): boolean
```

Iterates through the elements of the _input_ [Table](#table) in no particular order.

Calls the _handler_ for each entry and returns `true` if the handler returns truthy for any
element which it is called with.

<hr>

### values

<span class="tags">
	[Maps](#maps)
</span>

```lua
values(input: Types.Map<any, any>): Types.Array<any>
```

Returns an [Array](#array) of the values in the _input_ Table.

If the input is an Array, ordering is preserved.

If the input is a Map, values are returned in an arbitrary order.

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
endsWith(input: string, suffix: string)
```

Checks if _input_ ends with the string _suffix_.

**Examples**

```lua
endsWith("Fun Roblox Games", "Games") --> true
```

```lua
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
the english alphabet. This function has been implemented to return the expected result once
this has been corrected.

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
the english alphabet. This function has been implemented to return the expected result once
this has been corrected.

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

```lua
leftPad("toast", 6) --> " toast"
```

```lua
leftPad("2", 2, "0") --> "02"
```

```lua
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

```lua
rightPad("toast", 6) --> "toast "
```

```lua
rightPad("2", 2, "!") --> "2!"
```

```lua
rightPad("toast", 10, ":)") --> "toast:):):"
```

<hr>

### splitOn

<span class="tags">
	[Strings](#strings)
</span>

```lua
splitOn(input: string, pattern: string): Types.Array<string>
```

Splits _input_ into parts based on a _pattern_ delimiter and returns a [Table](#table) of the parts,
followed by a [Table](#table) of the matched delimiters.

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

```lua
startsWith("Fun Roblox Games", "Fun") --> true
```

```lua
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

<hr>

## Functions

These utilities are helpful for working with functions.

<hr>

### compose

<span class="tags">
	[Functions](#functions)
</span>

```
compose(...: Types.Array<Types.AnyFunction>): Types.AnyFunction
```

Returns a function that calls the argument functions in left-right order on an input, passing
the return of the previous function as argument(s) to the next.

**Example**

```lua
local function fry(item)
	return "fried " .. item
end
local function cheesify(item)
	return "cheesy " .. item
end
local prepare = compose(fry, cheesify)
prepare("nachos") --> "cheesy fried nachos"
```

<hr>

### forEachArgs

<span class="tags">
	[Functions](#functions)
</span>

```lua
forEachArgs(handler: Handler<Value>, ...: Args<Value>): ()
```

Iterates through the tail arguments in order, including nil values up to the argument list length.

Calls the [Handler](#handler) _handler_ for each entry.

<hr>

### identity

<span class="tags">
	[Functions](#functions)
</span>

```lua
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
isCallable(value: any): boolean
```

Returns `true` if the value can be called i.e. you can write `value(...)`.

<hr>

### noop

<span class="tags">
	[Functions](#functions)
</span>

```lua
noop()
```

A function which does nothing.

Can be used to make it clear that a handler has no function.

<hr>

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
thrown, and later passed to a logging endpoint.

Throwing an error instance captures its stack trace, avoiding the need to explicitly use xpcall.

**Fields**

| Name              | Description                                                                          |
| ----------------- | ------------------------------------------------------------------------------------ |
| `name: string`    | The name of the error                                                                |
| `message: string` | A message which will be formatted with [Dash.format](#format) if the error is thrown |
| `tags: Table`     | A table to store custom rich information about the error                             |
| `stack: string?`  | The value of `debug.traceback()` when the error is thrown                            |

**Methods**

| Name                      | Description                                                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `:joinTags(tags: Table?)` | Return a new error instance containing the tags provided joined to any existing tags of the current error instance.                                                         |
| `:throw(tags: Table?)`    | Throw an error.<br><br>The stack of the error is captured and stored.<br><br>If tags are provided, a new error is created and thrown with the joined tags of this instance. |

**Static Methods**

| Name                                                | Description                                      |
| --------------------------------------------------- | ------------------------------------------------ |
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

Symbols are useful when you want a value that isn't equal to any other type, for example if you
want to store a unique property on an object that won't be accidentally accessed with a simple
string lookup.

**Static Methods**

| Name                 | Description                                               |
| -------------------- | --------------------------------------------------------- |
| `.new(name: string)` | Returns a new unique `Symbol` instance with called _name_ |
| `.is(other: any)`    | Returns `true` if _other_ is a `Symbol` instance          |

**Example**

```lua
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
| ----------------------------- | ------------------------------------------------------------------------- |
| `:toString(): string`         | Returns a string representation of the class                              |
| `:equals(other: any):boolean` | Returns `true` if the instance is equal to _other_                        |
| `:_init()`                    | A private function which is called once the instance has been initialized |

**Static Methods**

| Name                               | Description                                           |
| ---------------------------------- | ----------------------------------------------------- |
| `.new(...): Table`                 | Returns a new instance of the class                   |
| `.isInstance(value: any): boolean` | Returns `true` if _value_ is an instance of the class |

**Examples**

```lua
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
car.wheelCount --> 4
car.speed --> 0
-- Drive the car
car:drive(10)
car.speed --> 10
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
assertEqual(left: any, right: any, formattedErrorMessage: string?)
```

Performs a simple equality check and throws an error if _left_ is not equal to _right_.

The formatted error message can be customized, which by default provides a serialization of
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
| --------- | -------------------- | --------------------------------------------------- |
| `omit`    | `Array<any>`         | An array of keys which should not be visited        |
| `visited` | `Set<Table>`         | A set of tables which were visited recursively      |
| `refs`    | `Map<Table, number>` | A map from table to unique index in visit order     |
| `nextRef` | `number`             | The number to use for the next unique table visited |

<hr>

### format

<span class="tags">
	[Debugging](#debugging) | [Strings](#strings)
</span>

```lua
format(formatString: string, ...)
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

```lua
local props = {"teeth", "claws", "whiskers", "tail"}
format("{} is in {:#?}", "whiskers", props)
--> [[whiskers is in {"teeth", "claws", "whiskers", "tail"}]]
```

```lua
format("The time is {:02}:{:02}", 2, 4) -> "The time is 02:04"
```

```lua
format("The color blue is #{:06X}", 255) -> "The color blue is #0000FF"
```

**Usage**

- Escape `{` with `{{` and `}` similarly with `}}`.
- See [https://developer.roblox.com/articles/Format-String](https://developer.roblox.com/articles/Format-String) for complete list of formating options and further use cases.

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

```lua
formatValue(255, "06X") --> "0000FF"
```

```lua
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
| ----------- | ------------- | ------------------------------------------------------------------------------------------- |
| `depth`     | `number?`     | The maximum depth of ancestors of a table to display                                        |
| `omit`      | `Array<any>?` | An array of keys which should not be visited                                                |
| `multiline` | `boolean?`    | Whether to use multiple lines (default = false)                                             |
| `noQuotes`  | `boolean?`    | Whether to drop the quotation marks around strings. By default, this is true for table keys |
| `indent`    | `string?`     | The indent string to use (default = "\t")                                                   |
| `visited`   | `Set<Table>?` | A set of tables which have already been visited and should be referred to by reference      |
| `cycles`    | `Cycles?`     | A cycles object returned from `cycles` to aid reference display                             |

**See**

- [Dash.cycles](#cycles)

<hr>
