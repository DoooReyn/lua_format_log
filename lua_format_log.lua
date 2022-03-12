--[[
Copyright 2022 DoooReyn

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]] --

local function get_lua_stack(from, max_depth)
    from = from or 2
    max_depth = max_depth or 3
    local info
    local depth = 1
    local level = from
    local fmt = ' -> [{1}] {2}:{3}'
    local stack = {}

    repeat
        info = debug.getinfo(level, 'Sl')
        if info and info.what == 'Lua' and not info.source:match('lua_format_log') then
            stack[#stack + 1] = fmt:interpolate({depth, info.source, info.currentline})
            depth = depth + 1
            if depth > max_depth then
                break
            end
        end
        level = level + 1
    until (not info)

    return table.concat(stack, '\n')
end

local __internals__ = {
    __VERSION__ = '0.0.1',
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
    __patterns = {'%D', '%U', '%L', '%S', '%V'},
    __pattern = '[--%L--] [%D.%U]\n%S\n => %V\n',
    __target = 'stdout',
    __stack_max_depth = 3,
    __use_stdout = true,
    __out_file = nil
}

function __internals__:__compile_pattern(level, msg)
    local str = self.__pattern
    for _, v in ipairs(self.__patterns) do
        local p = '%' .. v
        if str:match(p) then
            local r = ''
            if v == '%D' then
                r = os.date('%Y/%m/%d %H:%M:%S')
            elseif v == '%U' then
                r = tostring(os.clock()):gsub('%.', ''):sub(1, 3)
            elseif v == '%L' then
                r = self.__abbrs[level]
            elseif v == '%S' then
                r = get_lua_stack(2)
            elseif v == '%V' then
                r = tostring(msg)
            end
            str = str:gsub('%' .. v, r)
        end
    end

    if level >= self.__level then
        if self.__use_stdout then
            print(str)
        end
        if self.__out_file then
            self:__flush_file(str)
        end
    end

    return str
end

function __internals__:__flush_file(str)
    local fp = io.open(self.__out_file, 'a')
    fp:write(str)
    fp:close()
end

function __internals__:__compile(level, ...)
    local fmt = {}
    for i = 1, select('#', ...) do
        fmt[#fmt + 1] = '{' .. i .. '}'
    end
    local msg = table.concat(fmt, '  '):interpolate({...})
    return self:__compile_pattern(level, msg)
end

local lua_format_log = {}
setmetatable(lua_format_log, {__index = __internals__})

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
        self.__pattern = p
    end
end

function lua_format_log:set_use_stdout(b)
    self.__use_stdout = not (not b)
end

function lua_format_log:set_out_file(filepath)
    self.__out_file = filepath
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
