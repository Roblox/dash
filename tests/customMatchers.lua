-- Checks that toString represenation of the error includes given message
local function toThrowWithMessage(_, received, errorMessage)
	local ok, error = pcall(received)
	local pass = not ok and string.find(error:toString(), errorMessage) ~= nil
	local message
	if pass then
		message = function()
			return `expected {error} not to include {errorMessage}`
		end
	else
		message = function()
			return `expected {error} to include {errorMessage}`
		end
	end
	return { message = message, pass = pass }
end

return {
	toThrowWithMessage = toThrowWithMessage,
}
