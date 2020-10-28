--[[
	Makes a string of `length` from `input` by repeating characters from `prefix` at the start of the string.
	@example leftPad("toast", 6) --> " toast"
	@example leftPad("2", 2, "0") --> "02"
	@example leftPad("toast", 10, ":)") --> ":):):toast"
	@param prefix (default = `" "`)
]]
local function leftPad(input: string, length: number, prefix: string?): string
	prefix = prefix or " "
	local padLength = length - #input
	local remainder = padLength % #prefix
	local repetitions = (padLength - remainder) / #prefix
	return string.rep(prefix or " ", repetitions) .. prefix:sub(1, remainder) .. input
end

return leftPad