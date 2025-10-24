## V3.3.0

- Added `Dash.union` to merge two dictionaries together immutably

## V3.2.0

- Added `Dash.joinArrays` to join multiple array-based tables together immutably

## V3.1.1

- Added any parameter to the `noop` function

## V3.0.0

- Fixed exports to preserve types
- Changed stricten `freeze` types
- Changed `joinDeep` to use `table.clone` instead of `Dash.copy`
- Added `get`
- Added `debounce`
- Added `throttle`
- Added `pipe`. Same as compose, mainly the name improvement
- Removed `compose`. Should've been right to left, but since it was left to right, it's renamed to `pipe`
- Removed `Array` and `Args` types. They are well-supported by luau.
- Deprecated `copy`, use `table.clone`
- Deprecated `freeze`, use `table.freeze`

## V2.1.0

- Create `memoize`

## V2.0.0

- Replaced `pairs` with generalized iteration
- Added types and tests for `pretty` function
- Fixed typos in docs
- Added manual exports for the LSP
- Updated `install-packages-to-branch` action
- Updated tooling

## V1.1.0

- Added chain function to chain stateful iterators

## v1.0.0

- Changed types to support generics. Type inference should become better.
- Removed types assertions, you must rely on type checker support
- Added zip function to iterate over pairs of elements of the given arrays
- Added all function to check whether all elements conform to the condition
- Added count function to count elements conforming to the condition
- Added frequencies function to count how many times values are encountered in the table
- Added max, min, sum, product functions

## v0.1.9

- Changed package name to Dash

## v0.1.8

- Added helper types for array/set/map/functions

## v0.1.7

- Added stack to the `Error:toString()` (29335cd)[29335cd2249f9265ae388f05e01a95487d4b167a]

## v0.1.6

- Move tests to separate folder so they are not included in runtime build

## v0.1.5

- Move to Roblox repository

## v0.1.4

- collect utilities use iterator
- added Dash.pick

## v0.1.3

- Add iterate and iterable to allow utilities to accept both maps and arrays

## v0.1.2

- Attempt to fix rotriever package definition

## v0.1.1

- Attempt to fix rotriever package definition

## v0.1.0

- Initial release of Dash
