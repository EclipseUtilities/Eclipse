# Eclipse
This documentation is to ensure that all people who use Eclipse UI Library know how to use it.
<br>
<sub>*Eclipse Legacy has been depreciated, therefore there is no documentation on it.</sub>
<br><br>
## Booting The Library
```lua
local Eclipse = loadstring(game:HttpGet('https://raw.githubusercontent.com/qalue/projects/main/EclipseUILibrary.lua',true))()
```
<br><br><br>


## Creating a Window

```lua
Eclipse:CreateWindow()
```

## Creating a Section

```lua
Eclipse:CreateSection("Text to Display")

--[[
text : <string> : Text that is displayed on the section.
]]
```

## Creating a Button

```lua
Eclipse:CreateButton("Text to Display", function()

end)

--[[
text : <string> : Text that is displayed on the button.
function : <function> : The script that is ran upon the user clicking the button.
]]
```

## Creating a Toggle


```lua
Eclipse:CreateToggle("Text to Display", function(state)

end)

--[[
text : <string> : Text that is displayed on the toggle.
function : <function> : The script that is ran upon the user clicking the toggle.
state : <boolvalue> : Activates every time the toggle is clicked, returns whether the toggle is set to true or false.
]]
```

## Creating a Bind


```lua
Eclipse:CreateBind("Text to Display", function()

end)

--[[
text : <string> : Text that is displayed on the bind.
function : <function> : The script that is ran upon the user pressing the bound key.
]]
```
