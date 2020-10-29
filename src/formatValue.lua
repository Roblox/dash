--[[
	Format a specific _value_ using the specified _displayString_.
	@example
		formatValue(255, ":06X") --> 0000FF
	@see `format` - for a full description of valid display strings.
]]

local Dash = script.Parent
local pretty = require(Dash.pretty)

local function formatValue(value, displayString: string)
	local displayTypeStart, displayTypeEnd = displayString:find("[A-Za-z#?]+")
	if displayTypeStart then
		local displayType = displayString:sub(displayTypeStart, displayTypeEnd)
		local formatAsString =
			"%" .. displayString:sub(1, displayTypeStart - 1) .. displayString:sub(displayTypeEnd + 1) .. "s"
		if displayType == "#?" then
			-- Multiline print a value
			return formatAsString:format(pretty(value, {multiline = true}))
		elseif displayType == "?" then
			-- Inspect a value
			return formatAsString:format(pretty(value))
		end
		return ("%" .. displayString):format(value)
	else
		local displayType = "s"
		if type(value) == "number" then
			-- Correctly display floats or integers
			local _, fraction = math.modf(value)
			displayType = fraction == 0 and "d" or "f"
		end
		return ("%" .. displayString .. displayType):format(tostring(value))
	end
end

return formatValue