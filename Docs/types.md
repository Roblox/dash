# Types

### Array

```lua
type Array<Value> = {[number]: Value}
```

A table with values of type _Value_ and numeric keys 1..n with no gaps

### Args

```lua
type Args<Value> = {[number]: Value}
```

A table with values of type _Value_ and numeric keys, possibly with gaps.

### Map

```lua
Map<Key, Value> = {[Key]: Value}
```

A table with keys of type _Key_ and values of type _Value_

### Set

```lua
type Set<Key> = {[Key]: boolean}
```

A table with keys of a fixed type _Key_ and a boolean value representing membership of the set (default is false)

### Dictionary

```lua
type Dictionary<Value> = {[string]: Value}
```

A table with string keys

### Table

```lua
type Table = {[any]: any}
```

A table of any type

### Class

```lua
type Class<Object> = {

new: () -> Object
}
```

A class has a constructor returning an instance of _Object_ type

### Handler

```lua
type Handler<Value> = (Value, number) -> ()
```

A callback function for an `ipairs` iteration which is called with a value and index.

### PairsHandler

```lua
type PairsHandler<Key, Value> = (Value, Key) -> ()
```

A callback function for a `pairs` iteration which is called with a value and key.
