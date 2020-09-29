--!strict
--[[
	Return a pretty string serialization of any Lua value.

	This implementation deals with cycles in tables and can neatly display metatables.

	Optionally use an indented multiline string, limit the depth of tables, omit or pick keys.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local getCycles = require(Dash.getCycles)
local assign = require(Dash.assign)
local includes = require(Dash.includes)

export type PrettyOptions = {
	-- The maximum depth of ancestors of a table to display
	depth: number?
	-- Limit keys to a specific list of types
	omit: Types.Array<any>,
	-- Whether to use multiple lines (default = false)
	multiline: boolean?,
	-- Whether to drop the quotation marks around strings. By default, this is true for table keys
	noQuotes: boolean?
	-- The indent string to use (default = "\t")
	indent: string?,
	-- A set of tables which have already been visited and should be referred to by reference
	visited: Types.Set<Types.Table>,
	-- A cycles object returned from `dash.getCycles` to aid reference display
	cycles: getCycles.Cycles,
}

local function pretty(object: any, options: PrettyOptions): string
	options = options or {}
	if type(object) == "table" then
		-- A table needs to be serialized recusively
		-- Construct the options for recursive calls for the table values
		local valueOptions = {
			omit = options.omit,
			-- Depth is reduced until we shouldn't recurse any more
			depth = options.depth and options.depth - 1 or nil,
			visited = options.visited or {},
			cycles = options.cycles or getCycles(object, {
				visited = {},
				refs = {},
				nextRef = 0,
				omit = options.omit or {}
			})
		}
		if valueOptions.depth == -1 then
			-- Indicate there is more information available beneath the maximum depth
			return "..."
		end
		if valueOptions.visited[object] then
			-- Indicate this table has been printed already, so print a ref number instead of
			-- printing it multiple times
			return "&" .. valueOptions.cycles.refs[object]
		end
		
		valueOptions.visited[object] = true
		-- If the table appears multiple times in the output, mark it with a ref prefix so it can
		-- be identified if it crops up later on
		local ref = valueOptions.cycles.refs[object]
		local refTag = ref and ("<" .. ref .. ">") or ""
		local output = refTag .. "{"
		local first = true
		-- Build the options for the recursive call for the table keys
		local keyOptions = assign({
			noQuotes = true
		}, valueOptions)
		for key, value in pairs(object) do
			if valueOptions.omit and includes(valueOptions.omit, key) then
				-- Don't include keys which are omitted
				continue
			end
			if first then
				first = false
			else
				output = output .. ", "
			end
			output = output .. pretty(key, keyOptions) .. " = " .. pretty(value, valueOptions)
		end
		output = output .. "}"
		return output
	elseif type(object) == "string" and not options.noQuotes then
		return '"' .. object .. '"'
	else
		return tostring(object)
	end
end

return pretty