# Classes

## Error

```lua
Error.new(name: string, message: string, tags: Table?)
```

Create an error object with a specified name and message.

In native Lua, errors can only be string values. At Roblox, we can take advantage of throwing
error objects to provide structured information about problems that occur.

The tags table stores serializable information about an error which can be provided when it is
thrown, and later passed to a logging endpoint.

Throwing an error instance captures its stack trace, avoiding the need to explicitly use xpcall.

**Fields**

| Name              | Description |
| ----------------- | ----------- |
| `name: string`    |             |
| `message: string` |             |
| `tags: Table`     |             |
| `stack: string?`  |             |

**Methods**

| Name                      | Description                                                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `:joinTags(tags: Table?)` | Return a new error instance containing the tags provided joined to any existing tags of the current error instance.                                                         |
| `:throw(tags: Table?)`    | Throw an error.<br><br>The stack of the error is captured and stored.<br><br>If additional tags are provided, a new error is created with the joined tags of this instance. |

**Static Methods**

| Name                                                | Description                                      |
| --------------------------------------------------- | ------------------------------------------------ |
| `.new(name: string, message: string, tags: Table?)` | Returns a new `Error` instance                   |
| `.is(other: any)`                                   | Returns `true` if _other_ is an `Error` instance |

**Usage**

In general, errors should not be used during normal control flow.

## Symbol

Create a symbol with a specified name. We recommend upper snake-case as the symbol is a
constant, unless you are linking the symbol conceptually to a different string.

Symbols are useful when you want a value that isn't equal to any other type, for example if you
want to store a unique property on an object that won't be accidentally accessed with a simple
string lookup.

**Static Methods**

| Name                 | Description                                               |
| -------------------- | --------------------------------------------------------- |
| `.new(name: string)` | Returns a new unique `Symbol` instance with called _name_ |
| `.is(other: any)`    | Returns `true` if _other_ is a `Symbol` instance          |

**Examples**

```lua
local CHEESE = Symbol.new("CHEESE")
local FAKE_CHEESE = Symbol.new("CHEESE")
print(CHEESE == CHEESE) --> true
print(CHEESE == FAKE_CHEESE) --> false
print(tostring(CHEESE)) --> "Symbol.new(CHEESE)"
```
