local function getLuaStack(from)
	local info = nil
    local _level = from - 1
    local level = from
    local stack = {}
    
    repeat 
        info = debug.getinfo(level, "nSlf")
        if info then
            stack[#stack+1] = (" -> [{1}] {2}:{3}"):interpolate({level - _level, info.source, info.currentline})
        end
        level = level + 1
    until(not info)

    return table.concat(stack, "\n")
end

local internals = {
	__VERSION__ = "0.0.1",
	levels = {
		trace = 1,
		debug = 2,
		info = 3,
		warn = 4,
		error = 5,
		fatal = 6,
		off = 7
	},
	__level = 1,
	__abbrs = {'T', 'D', 'I', 'W', 'E', 'F', '_'},
	__patterns = {'%D', '%U', '%L', '%S', '%F', '%V'},
	__pattern = '[%L] [%D%U]\n%S\n => %V\n',
	__target = 'stdout'
}

local lua_format_log = {}
setmetatable(lua_format_log, {__index = internals})

function lua_format_log:get_level()
	return self.__level
end

function lua_format_log:set_level(level)
	level = math.floor(level)
	if level >= self.levels.trace and level <= self.levels.off then
		self.__level = level
	end
end

function lua_format_log:set_pattern(p)
	if type(p) == 'string' then
		this.__pattern = p
	end
end

function lua_format_log:__compile_pattern(level, msg)
	local str = self.__pattern
	for _, v in ipairs(self.__patterns) do
		local p = '%' .. v
		if string.match(str, p) then
			local r = ''
			if v == '%D' then
				r = os.date('%Y/%m/%d %H:%M:%S')
			elseif v == '%U' then
				r = math.floor(os.clock())
			elseif v == '%L' then
				r = self.__abbrs[level]
			elseif v == '%S' then
				r = getLuaStack(3)
			elseif v == '%V' then
				r = tostring(msg)
			end
			str = string.gsub(str, '%'..v, r)
		end
	end

	if level >= self.__level then
		print(str)
		self:__flushFile(str)
	end

	return str
end

function lua_format_log:__flushFile(str)
	if self.__target ~= "stdout" then
		--TODO
	end
end

function lua_format_log:setTarget(target)
	self.__target = target
end

function lua_format_log:__compile(level, ...)
	local fmt = {}
	for i=1, select("#", ...) do
		fmt[#fmt+1] = '{' .. i .. '}'
	end
	local msg = table.concat( fmt, "  "):interpolate({...})
	return self:__compile_pattern(level, msg)
end

function lua_format_log:trace(...)
	return self:__compile(self.levels.trace, ...)
end

function lua_format_log:debug(...)
	return self:__compile(self.levels.debug, ...)
end

function lua_format_log:info(...)
	return self:__compile(self.levels.info, ...)
end

function lua_format_log:warn(...)
	return self:__compile(self.levels.warn, ...)
end

function lua_format_log:error(...)
	return self:__compile(self.levels.error, ...)
end

function lua_format_log:fatal(...)
	return self:__compile(self.levels.fatal, ...)
end

return lua_format_log
