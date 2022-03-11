# lua_format_log

## Format

- `%D`: Date
- `%U`: Time Elapse
- `%L`: Log Level
- `%S`: Lua Call Stack
- `%V`: Log Message

## Usage

```lua
local log = require("lua_format_log")
log:set_level(log.levels.trace)
log:set_pattern('[%L] [%D%U]\n%S\n => %V\n')
log:trace("this is trace message")
log:debug("this is debug message")
log:info("this is info message")
log:warn("this is warn message")
log:error("this is error message")
log:fatal("this is fatal message")
```

```cmd
[LUA-print] [T] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:2
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is trace message

[LUA-print] [D] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:3
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is debug message

[LUA-print] [I] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:4
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is info message

[LUA-print] [W] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:5
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is warn message

[LUA-print] [E] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:6
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is error message

[LUA-print] [F] [2022/03/12 00:02:220]
 -> [1] .\app/views/MainScene.lua:7
 -> [2] =[C]:-1
 -> [3] =[C]:-1
 -> [4] .\packages/mvc/AppBase.lua:48
 -> [5] .\packages/mvc/AppBase.lua:40
 -> [6] .\packages/mvc/AppBase.lua:36
 -> [7] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:26
 -> [8] =[C]:-1
 -> [9] F:/repo/game/bee-native-engine/win32-build/bin/bee-native-engine/Debug/Resources/src/main.lua:29
 => this is fatal message
```

## TODO

- ✔ stdout
- ✔ file
