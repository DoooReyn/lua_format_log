# lua_format_log

## Dependencies

- [lua-string-interpolate](https://github.com/DoooReyn/lua-string-interpolate)

## Format

- `%D`: Date
- `%U`: Time Elapse
- `%L`: Log Level
- `%S`: Lua Call Stack
- `%V`: Log Message

## Usage

```lua
local logger = require("lua_format_log")
logger:set_pattern('[---%L---] [%D.%U]\n%S\n => %V\n')
logger:set_level(logger.levels.info)
logger:set_use_stdout(true)
logger:info(('level = {1}'):interpolate({logger:get_level()}))
local fmt = 'Hi! {who} am {name}, {who} am from {from}'
local msg = fmt:interpolate({who = 'I', name = 'DoooReyn', from = 'China'})
logger:trace(msg) -- can't see
logger:debug(msg) -- can't see
logger:info(msg)  -- ok
logger:warn(msg)  -- ok
logger:error(msg) -- ok
logger:fatal(msg) -- ok
```

```cmd
[LUA-print] [---I---] [2022/03/12 10:43:31.058]
 -> [1] .\app/views/MainScene.lua:232
 -> [2] .\app/views/MainScene.lua:27
 -> [3] .\packages/mvc/ViewBase.lua:20
 => level = 3

[LUA-print] [---I---] [2022/03/12 10:43:31.058]
 -> [1] .\app/views/MainScene.lua:237
 -> [2] .\app/views/MainScene.lua:27
 -> [3] .\packages/mvc/ViewBase.lua:20
 => Hi! I am DoooReyn, I am from China

[LUA-print] [---W---] [2022/03/12 10:43:31.058]
 -> [1] .\app/views/MainScene.lua:238
 -> [2] .\app/views/MainScene.lua:27
 -> [3] .\packages/mvc/ViewBase.lua:20
 => Hi! I am DoooReyn, I am from China

[LUA-print] [---E---] [2022/03/12 10:43:31.058]
 -> [1] .\app/views/MainScene.lua:239
 -> [2] .\app/views/MainScene.lua:27
 -> [3] .\packages/mvc/ViewBase.lua:20
 => Hi! I am DoooReyn, I am from China

[LUA-print] [---F---] [2022/03/12 10:43:31.058]
 -> [1] .\app/views/MainScene.lua:240
 -> [2] .\app/views/MainScene.lua:27
 -> [3] .\packages/mvc/ViewBase.lua:20
 => Hi! I am DoooReyn, I am from China
```

## TODO

- ✔ stdout
- ✔ file
