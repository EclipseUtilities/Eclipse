# Eclipse
This documentation is to ensure that all people who use Eclipse UI Library know how to use it.
<br><br>
## Booting The Library
```lua
local EclipseLibraryLegacy = loadstring(game:HttpGet("https://raw.githubusercontent.com/qalue/projects/main/uilibrary.lua",true))()
```
<br><br><br>


## Creating a Window

```lua
local Window = EclipseLibraryLegacy:CreateWindow()
```

## Creating a Button

```lua
Window:Button("Text to Display", function()

end)

--[[
text : <string> : Text that is displayed on the button.
function : <function> : The script that is ran upon the user clicking the button
]]
```
