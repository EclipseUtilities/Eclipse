# Eclipse
This documentation is to ensure that all people who use Eclipse UI Library know how to use it.
<br><br>
## Booting The Library
```lua
local EclipseLegacy = loadstring(game:HttpGet("https://raw.githubusercontent.com/qalue/projects/main/uilibrary.lua",true))()
```
<br><br><br>


## Creating a Window

```lua
EclipseLegacy:CreateWindow()
```

## Creating a Button

```lua
EclipseLegacy:Button("Text to Display", function()

end)

--[[
text : <string> : Text that is displayed on the button.
function : <function> : The script that is ran upon the user clicking the button
]]
```

## Creating a Toggle


```lua
EclipseLegacy:Toggle("Text to Display", function(state)

end)

--[[
text : <string> : Text that is displayed on the button.
function : <function> : The script that is ran upon the user clicking the button
state : <boolvalue> : Activates every time the toggle is clicked, returns whether the toggle is set to true or false
]]
```
