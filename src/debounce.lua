--[[
	Creates and returns a new debounced version of the passed function which will postpone its execution
	until after `wait` seconds have elapsed since the last time it was invoked.

	@param func The function to debounce.
	@param wait The number of seconds to delay.
	@returns The new debounced function.
]]
local function debounce<T>(func: T & (...any) -> ...any, wait: number): T
	local delayedCall = nil
	return (
		function(...)
			if delayedCall then
				task.cancel(delayedCall)
			end
			delayedCall = task.delay(wait, func, ...)
		end :: unknown
	) :: T
end

return debounce
