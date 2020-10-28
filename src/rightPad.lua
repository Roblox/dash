--[[
	Makes a string of `length` from `input` by repeating characters from `suffix` at the end of the string.
	@example rightPad("toast", 6) --> "toast "
	@example rightPad("2", 2, "!") --> "2!"
	@example rightPad("toast", 10, ":)") --> "toast:):):"
]]
--: string, number, string -> string
local function rightPad(input: string, length: number, suffix: string?): string
	suffix = suffix or " "
	local padLength = length - #input
	local remainder = padLength % #suffix
	local repetitions = (padLength - remainder) / #suffix
	return input .. string.rep(suffix or " ", repetitions) .. suffix:sub(1, remainder)
end

return rightPad