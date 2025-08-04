--[[
	Gets the value at path of object. If the resolved value is nil, the defaultValue is returned in its place.

	@param object table The table to query
	@param path string|table The path of the property to get, can be a string using dots as separators or an array of keys
	@param defaultValue any The value returned for nil resolved values
	@return any The resolved value or defaultValue if path doesn't exist
]]

local function splitPath(path: string): { any }
	local result = {}
	local current = ""

	for i = 1, #path do
		local char = string.sub(path, i, i)
		if char == "." then
			if current ~= "" then
				-- Try to convert numeric strings to numbers for array indexing
				local num = tonumber(current)
				table.insert(result, num or current)
				current = ""
			end
		else
			current = current .. char
		end
	end

	if current ~= "" then
		-- Try to convert numeric strings to numbers for array indexing
		local num = tonumber(current)
		table.insert(result, num or current)
	end

	return result
end

local function get<T>(object: { [any]: any }, path: string | { any }, defaultValue: T?): T?
	if object == nil then
		return defaultValue
	end

	local segments
	if type(path) == "string" then
		segments = splitPath(path)
	else
		segments = path
	end

	local current = object
	for _, key in ipairs(segments) do
		if type(current) ~= "table" then
			return defaultValue
		end

		current = current[key]

		if current == nil then
			return defaultValue
		end
	end

	return current
end

return get
