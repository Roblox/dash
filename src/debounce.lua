local Dash = script.Parent
local assign = require(Dash.assign)

type DebounceOptions = {
	delay: number?,
	leading: boolean?,
	trailing: boolean?,
}

type DebounceOptionsInternal = {
	delay: number,
	leading: boolean,
	trailing: boolean,
}

-- `& (...any) -> ...any` in the function type is a funky way to mimick `T extends function`
type AnyVoidFunction = (...any) -> ()
type Debounced<T> = T & AnyVoidFunction

--[=[
	Creates and returns a new debounced version of the passed function which postpones execution until after
	_wait_ seconds have elapsed since the last invocation.

	@param func The function to debounce.
	@param options Either the number of seconds to delay, or a table of debounce options:
		- delay: number? (seconds to delay; default 0)
		- leading: boolean? (if true, call at the start of the delay; default false)
		- trailing: boolean? (if true, call at the end of the delay; default true)
	@return The new debounced function.
]=]
local function debounce<T>(func: T & AnyVoidFunction, options: number | DebounceOptions): Debounced<T>
	local defaultOptions: DebounceOptionsInternal = {
		delay = 0,
		leading = false,
		trailing = true,
	}

	local resolvedOptions: DebounceOptionsInternal
	if type(options) == "number" then
		resolvedOptions = assign(defaultOptions, { delay = options }) :: DebounceOptionsInternal
	elseif type(options) == "table" then
		resolvedOptions = assign(defaultOptions, options) :: DebounceOptionsInternal
	else
		resolvedOptions = defaultOptions
	end

	local delay = math.max(0, resolvedOptions.delay)
	local callId = 0
	local thread: thread? = nil
	local resetThread: thread? = nil
	local isLeadingCalled = false
	
	return function(...)
		local args = table.pack(...)
		callId += 1
		local currentCallId = callId
		local leading = resolvedOptions.leading
		local trailing = resolvedOptions.trailing
		local shouldCallLeading = leading and not isLeadingCalled
		
		-- Clear existing timeout
		if thread then
			task.cancel(thread)
			thread = nil
		end
		if resetThread then
			task.cancel(resetThread)
			resetThread = nil
		end
		
		-- Call leading if this is the first call and leading is enabled
		if shouldCallLeading then
			isLeadingCalled = true
			(func :: AnyVoidFunction)(table.unpack(args, 1, args.n))
		end
		
		-- Set up trailing call if enabled
		if trailing then
			thread = task.delay(delay, function()
				if callId == currentCallId then
					-- Reset leading flag for next cycle
					isLeadingCalled = false
					-- Only call if this wasn't already called by leading
					if not shouldCallLeading then
						(func :: AnyVoidFunction)(table.unpack(args, 1, args.n))
					end
				end
			end)
		else
			-- If trailing is disabled, reset leading flag after delay
			if leading then
				resetThread = task.delay(delay, function()
					if callId == currentCallId then
						isLeadingCalled = false
					end
				end)
			end
		end
	end :: Debounced<T>
end

return debounce
