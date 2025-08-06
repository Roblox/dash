--[[
	Gets the value at path of object. If the resolved value is nil, the defaultValue is returned in its place.

	@param object table The table to query
	@param path table An array of keys to get value from object
	@param defaultValue any The value returned for nil resolved values
	@return any The resolved value or defaultValue if path doesn't exist

	Examples:
		get({ a = 1 }, { "a" }) --> 1
		get({ a = { b = 2 }}, { "a", "b" }) --> 2
		get({ a = { b = 2 }}, { "a", "c" }, 5) --> 5
]]

local function get<T>(object: { [any]: any }, path: { any }, defaultValue: T?): T?
	if object == nil then
		return defaultValue
	end

	local current = object

	for _, key in path do
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
