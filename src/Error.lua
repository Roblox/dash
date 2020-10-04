--!strict
--[[
	Create an error object with a specified name and message.

	In native Lua, errors can only be string values. At Roblox, we can take advantage of throwing
	error objects to provide structured information about problems that occur.

	The tags table stores serializable information about an error which can be provided when it is
	thrown, and later passed to a logging endpoint.

	Throwing an error instance captures its stack trace, avoiding the need to explicitly use xpcall.
	
	@usage In general, errors should not be used during normal control flow.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local join = require(Dash.join)

local Error = {}

-- TODO Luau: Define class types automatically
export type Error = typeof(Error)

function Error:__tostring(): string
	return format("{}: {}", self.name, format(self.message, self.tags))
end

--[[
	Return true if the value passed in is an Error instance.
]]
-- TODO Luau: Support type predicates
function Error.is(value: any): boolean -- value is Error
	return getmetatable(value) == Error
end

--[[
	Create a new Error instance.
	@param name The name of the error
	@param string A message for the error which will be formatted using Dash.format
	@param tags Any fixed tags 
]]
function Error.new(name: string, message: string, tags: Types.Table?): Error
	local error = {
		name = name,
		message = message,
		tags = tags
	}
	return setmetatable(error, Error)
end

--[[
	Return a new error instance containing the tags provided joined to any existing tags of the
	current error instance.
]]
function Error:joinTags(tags: Types.Table?): Error
	return Error.new(self.name, self.message, join(self.tags, tags))
end

--[[
	Throw an error.

	The stack of the error is captured and stored.

	If additional tags are provided, a new error is created with the joined tags of
	this instance.
]]
function Error:throw(tags: Types.Table?): never
	local instance = self:joinTags(tags)
	instance.stack = debug.traceback()
	error(instance)
end

return Error