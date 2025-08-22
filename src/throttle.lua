local Dash = script.Parent
local assign = require(Dash.assign)

--[=[
	Creates and returns a new throttled version of the passed function which ensures the function
	is called at most once during the specified window. Optionally calls at the start (leading)
	and/or at the end (trailing) of the window.

	Example:
	```
	local throttled = throttle(function(v) print(v) end, 0.1)
	for i = 1, 10 do throttled(i) end
	-- prints: 1 (immediately), 10 (after ~0.1s)
	```

	@param func The function to throttle.
	@param options Either the number of seconds to delay, or a table of throttle options:
		- delay: number? (seconds to throttle; default 0)
		- leading: boolean? (if true, call at the start of the window; default true)
		- trailing: boolean? (if true, call at the end of the window; default true)
	@returns The new throttled function.
]=]

type ThrottleOptions = {
	delay: number?,
	leading: boolean?,
	trailing: boolean?,
}

type ThrottleOptionsInternal = {
	delay: number,
	leading: boolean,
	trailing: boolean,
}

type AnyVoidFunction = (...any) -> ()
type Throttled<T> = T & AnyVoidFunction

local function throttle<T>(func: T & AnyVoidFunction, options: number | ThrottleOptions): Throttled<T>
	local defaultOptions: ThrottleOptionsInternal = {
		delay = 0,
		leading = true,
		trailing = true,
	}

	local resolvedOptions: ThrottleOptionsInternal
	if type(options) == "number" then
		resolvedOptions = assign(defaultOptions, { delay = options }) :: ThrottleOptionsInternal
	elseif type(options) == "table" then
		resolvedOptions = assign(defaultOptions, options) :: ThrottleOptionsInternal
	else
		resolvedOptions = defaultOptions
	end

	local delay = math.max(0, resolvedOptions.delay)
	local leading = resolvedOptions.leading
	local trailing = resolvedOptions.trailing

	local lastExecutionTime = -math.huge
	local scheduledThread: thread? = nil
	local lastArgs: { [number]: any, n: number }? = nil

	local function clearScheduled()
		if scheduledThread then
			task.cancel(scheduledThread)
			scheduledThread = nil
		end
	end

	local function invoke()
		lastExecutionTime = os.clock()
		scheduledThread = nil
		local args = lastArgs :: { [number]: any, n: number }
		(func :: AnyVoidFunction)(table.unpack(args, 1, args.n))
	end

	return (
		function(...)
			local now = os.clock()
			lastArgs = table.pack(...)
			local timeSinceExecution = now - lastExecutionTime

			if leading and timeSinceExecution >= delay then
				clearScheduled()
				invoke()
				return
			end

			if trailing and not scheduledThread then
				local baseTime = (lastExecutionTime == -math.huge) and now or lastExecutionTime
				local remaining = delay - (now - baseTime)
				if remaining < 0 then
					remaining = 0
				end
				scheduledThread = task.delay(remaining, invoke)
			end
		end :: unknown
	) :: Throttled<T>
end

return throttle
