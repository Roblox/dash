local Dash = script.Parent
local assign = require(Dash.assign)

type ThrottleOptions = {
	leading: boolean?,
	trailing: boolean?,
}

type ThrottleOptionsInternal = {
	leading: boolean,
	trailing: boolean,
}

-- `& (...any) -> ...any` in the function type is a funky way to mimick `T extends function`
type AnyVoidFunction = (...any) -> ()
type Throttled<T> = T & AnyVoidFunction
type Args = { [number]: any, n: number }

--[=[
	Creates and returns a new throttled version of the passed function which will ensure that the function is
	called at most once during the specified wait period. If called multiple times during the wait period, only
	the first call will be executed immediately, and subsequent calls will be ignored until the wait period has elapsed.

	The last call will always be done after the same delay.
	```

	@param func The function to throttle.
	@param wait The number of seconds to throttle invocations to.
	@param options Optional throttle options:
		- leading: boolean? (if true, call at the start of the window; default true)
		- trailing: boolean? (if true, call at the end of the window; default true)
	@return The new throttled function.
	@example
	```luau
		local throttled = throttle(function(v) print(v) end, 0.1)
		for i = 1, 10 do
			throttled(i)
		end
		-- Would result in:
		-- 1
		-- 10
	```
]=]
local function throttle<T>(func: T & AnyVoidFunction, wait: number, options: ThrottleOptions?): Throttled<T>
	local defaultOptions: ThrottleOptionsInternal = {
		leading = true,
		trailing = true,
	}

	local resolvedOptions: ThrottleOptionsInternal
	if type(options) == "table" then
		resolvedOptions = assign(defaultOptions, options) :: ThrottleOptionsInternal
	else
		resolvedOptions = defaultOptions
	end

	local delay = math.max(0, wait)
	local leading = resolvedOptions.leading
	local trailing = resolvedOptions.trailing

	local lastExecutionTime = -math.huge
	local scheduledThread: thread? = nil
	local lastArgs: Args? = nil

	local function clearScheduled()
		if scheduledThread then
			task.cancel(scheduledThread)
			scheduledThread = nil
		end
	end

	local function invoke()
		lastExecutionTime = os.clock()
		scheduledThread = nil
		local args = lastArgs :: Args;
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
