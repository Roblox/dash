# Functions

## assign

```lua
assign(target: Table, ...: Args<Table>): Table
```

Adds new values to _target_ from subsequent [Table](../types/#table) arguments in left-to-right order.

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

- [join](#join)

## cycles

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

## forEach

```lua
forEach(input: Array<Value>, handler: Handler<Value>): ()
```

Iterates through the elements of the [Array](../types/#array) _input_ using the ordered keys 1..n.

Calls the [Handler](../types/#handler) _handler_ for each entry.

## forEachArgs

```lua
forEachArgs(handler: Handler<Value>, ...: Args<Value>): ()
```

Iterates through the tail arguments in order, including nil values up to the argument list length.

Calls the [Handler](../types/#handler) _handler_ for each entry.

## forEachPairs

```lua
forEachPairs(input: Map<Key, Value>, handler: PairHandler<Key, Value>): ()
```

Iterates through the elements of the [Map](../types/#map) _input_ in no guaranteed order.

Calls the [PairHandler](../types/#handler) _handler_ for each entry.

## freeze

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

**Examples**

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

## includes

```lua
includes(source: Table, value: any): boolean
```

Returns _true_ if the _item_ exists as a value in the _source_ [Table](../types/#table).

## join

```lua
join(...: Args<Table>): Table
```

Output a new [Table](../types/#table) from merging all the keys in the [Table](../types/#table) arguments in left-to-right order.

**See**

- [assign](#assign)

## pretty

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
