local window,frame,name=nil,nil,"Eclipse"
local keybind_listening=false
local UIS=game:GetService("UserInputService")
local first=true
local bindTable,lib,connectionTable={},{},{}

for _,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name==name then
        v:Destroy()
    end
end

function lib:CreateWindow()
    local defaultUIGradient=Instance.new("UIGradient")
    defaultUIGradient.Rotation=90
    defaultUIGradient.Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(200,200,200)),
        ColorSequenceKeypoint.new(0.25,Color3.fromRGB(200,200,200)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(89,89,89))
    }
    window=Instance.new("ScreenGui")
    window.Name=name

    frame=Instance.new("Frame")
    frame.AnchorPoint=Vector2.new(0.5,0.5)
    frame.Size=UDim2.new(0.25,0,0.35,0)
    frame.Position=UDim2.new(0.317,0,0.299,0)
    frame.BackgroundColor3=Color3.fromRGB(25,25,25)
    frame.Draggable=true
    frame.Selectable=true
    frame.Active=true
    frame.Parent=window

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,8)
    uiCorner.Parent=frame

    local dropShadow = Instance.new("ImageLabel")
    dropShadow.AnchorPoint=Vector2.new(0.5,0.5)
    dropShadow.Size=UDim2.new(1,30,1,30)
    dropShadow.Position=UDim2.new(0.5,0,0.5,0)
    dropShadow.BackgroundTransparency=1
    dropShadow.ImageColor3=Color3.fromRGB(15,15,15)
    dropShadow.ScaleType=Enum.ScaleType.Slice
    dropShadow.SliceCenter=Rect.new(24,24,276,276)
    dropShadow.SliceScale=1
    dropShadow.Image="http://www.roblox.com/asset/?id=6147985449"
    dropShadow.Parent=frame

    local text=Instance.new("TextLabel")
    text.Size=UDim2.new(1,0,0.09,0)
    text.BackgroundTransparency=1
    text.Font=Enum.Font.Gotham
    text.RichText=true
    text.Text="<b>ECLIPSE</b> Library"
    text.TextColor3=Color3.fromRGB(255,255,255)
    text.TextScaled=true
    text.TextXAlignment=Enum.TextXAlignment.Left
    defaultUIGradient.Parent=text
    text.Parent=frame

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.15, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=text

    local scrollingFrame=Instance.new("ScrollingFrame")
    scrollingFrame.AnchorPoint=Vector2.new(0.5,0.5)
    scrollingFrame.Position=UDim2.new(0.5,0,0.549,0)
    scrollingFrame.Size=UDim2.new(0.96,0,0.89,0)
    scrollingFrame.BackgroundTransparency=1
    scrollingFrame.ScrollBarThickness=0
    scrollingFrame.Parent=frame

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingTop=UDim.new(0,4)
    uiPadding.Parent=scrollingFrame

    local layout=Instance.new("UIListLayout")
    layout.Padding=UDim.new(0,3)
    layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
    layout.Parent=scrollingFrame
    layout.SortOrder=Enum.SortOrder.LayoutOrder

    window.Parent=game.CoreGui

    scrollingFrame.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
    scrollingFrame.ChildAdded:Connect(function(child)
        scrollingFrame.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+child.Size.Y.Offset+6+layout.Padding.Offset)
    end)
end

function lib:CreateSection(text)
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local sectionText=Instance.new("TextLabel")
    sectionText.BackgroundTransparency=1
    sectionText.TextXAlignment=Enum.TextXAlignment.Left
    sectionText.TextColor3=Color3.fromRGB(255,255,255)
    sectionText.Text=text
    sectionText.Size=UDim2.new(1,0,0,20)
    sectionText.Font=Enum.Font.GothamBold
    sectionText.TextScaled=true

    if not first then
        local gap=Instance.new("TextLabel")
        gap.BackgroundTransparency=1
        gap.Size=UDim2.new(1,0,0,10)
        gap.Text=""
        gap.Parent=toAddTo
    end

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.01,0)
    uiPadding.PaddingTop=UDim.new(0.075)
    uiPadding.PaddingBottom=UDim.new(0.075,0)
    uiPadding.Parent=sectionText

    local grad=Instance.new("UIGradient")
    grad.Rotation=90
    grad.Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(220,220,220)),
        ColorSequenceKeypoint.new(0.25,Color3.fromRGB(220,220,220)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(109,109,109))
    }
    grad.Parent=sectionText

    sectionText.Parent=toAddTo
    if first then first = false end
end

function lib:CreateLabel(text,centered)
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local label=Instance.new("TextLabel")
    label.BackgroundColor3=Color3.fromRGB(32,32,32)
    label.Font=Enum.Font.Gotham
    label.Text=text
    label.TextColor3=Color3.fromRGB(220,220,220)
    label.TextScaled=true
    label.TextXAlignment=(centered and Enum.TextXAlignment.Center)or(not centered and Enum.TextXAlignment.Left)
    label.Size=UDim2.new(1,0,0,35)

    local uiCorner=Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,5)
    uiCorner.Parent=label

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingRight=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.225, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=label

    label.Parent=toAddTo
end

function lib:CreateButton(text,script)
    script=script or function() end
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local button=Instance.new("TextButton")
    button.BackgroundColor3=Color3.fromRGB(32,32,32)
    button.Font=Enum.Font.Gotham
    button.Text=text
    button.TextColor3=Color3.fromRGB(220,220,220)
    button.TextScaled=true
    button.AutoButtonColor=false
    button.TextXAlignment=Enum.TextXAlignment.Left
    button.Size=UDim2.new(1,0,0,35)

    local uiCorner=Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,5)
    uiCorner.Parent=button

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingRight=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.225, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=button

    button.Parent=toAddTo

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
    end)
    
    button.MouseLeave:Connect(function()
       button.BackgroundColor3 = Color3.fromRGB(32,32,32)
    end)
    
    button.MouseButton1Click:Connect(function()
        pcall(script)
    end)
end

function lib:CreateToggle(text,script,defaultStatus)
    local enabled=defaultStatus or false
    script=script or function() end
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local toggleHolder=Instance.new("TextLabel")
    toggleHolder.BackgroundColor3=Color3.fromRGB(32,32,32)
    toggleHolder.Font=Enum.Font.Gotham
    toggleHolder.Text=text
    toggleHolder.TextColor3=Color3.fromRGB(220,220,220)
    toggleHolder.TextScaled=true
    toggleHolder.TextXAlignment=Enum.TextXAlignment.Left
    toggleHolder.Size=UDim2.new(1,0,0,35)

    local uiCorner=Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,5)
    uiCorner.Parent=toggleHolder

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingRight=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.225, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=toggleHolder

    local toggle=Instance.new("TextButton")
    toggle.AutoButtonColor=false
    toggle.AnchorPoint=Vector2.new(0.5,0.5)
    toggle.Text=""
    toggle.BackgroundColor3=enabled and Color3.fromRGB(57, 110, 71) or Color3.fromRGB(36,36,36)
    toggle.Size=UDim2.new(0,25,0,25)
    toggle.Position=UDim2.new(0.98,0,0.5,0)
    toggle.Parent=toggleHolder

    local uiCorner2=uiCorner:Clone()
    uiCorner2.Parent=toggle

    local uiStroke=Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    uiStroke.Color=Color3.fromRGB(50,50,50)
    uiStroke.Parent=toggle

    toggleHolder.Parent=toAddTo

    toggle.MouseEnter:Connect(function()
        if toggle.BackgroundColor3 ~= Color3.fromRGB(57, 110, 71) then
            toggle.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        end
    end)
    
    toggle.MouseLeave:Connect(function()
        if toggle.BackgroundColor3 ~= Color3.fromRGB(57, 110, 71) then
            toggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        end
    end)
    
    local function fire()
        enabled=not enabled
        toggle.BackgroundColor3=enabled and Color3.fromRGB(57, 110, 71) or Color3.fromRGB(36,36,36)
        pcall(script,enabled)
    end
    toggle.MouseButton1Click:Connect(fire)
end

function lib:CreateInput(infoText,text,script,int)
    script=script or function() end
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local inputHolder=Instance.new("TextLabel")
    inputHolder.BackgroundColor3=Color3.fromRGB(32,32,32)
    inputHolder.Font=Enum.Font.Gotham
    inputHolder.Text=text
    inputHolder.TextColor3=Color3.fromRGB(220,220,220)
    inputHolder.TextScaled=true
    inputHolder.TextXAlignment=Enum.TextXAlignment.Left
    inputHolder.Size=UDim2.new(1,0,0,35)

    local uiCorner=Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,5)
    uiCorner.Parent=inputHolder

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingRight=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.225, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=inputHolder

    local input=Instance.new("TextBox")
    input.AnchorPoint=Vector2.new(0.5,0.5)
    input.PlaceholderText=infoText
    input.PlaceholderColor3=Color3.fromRGB(75,75,75)
    input.TextColor3=Color3.fromRGB(210,210,210)
    input.Text=""
    input.Font=Enum.Font.Gotham
    input.BackgroundColor3=Color3.fromRGB(36, 36, 36)
    input.Size=UDim2.new(0.3,0,0,25)
    input.TextScaled=true
    input.Position=UDim2.new(0.858,0,0.5,0)
    input.Parent=inputHolder

    local uiPadding2=Instance.new("UIPadding")
    uiPadding2.PaddingLeft=UDim.new(0.08, 0)
    uiPadding2.PaddingRight=UDim.new(0.08, 0)
    uiPadding2.PaddingBottom=UDim.new(0.12, 0)
    uiPadding2.PaddingTop=UDim.new(0.12, 0)
    uiPadding2.Parent=input

    local uiCorner2=uiCorner:Clone()
    uiCorner2.Parent=input

    local uiStroke=Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    uiStroke.Color=Color3.fromRGB(50,50,50)
    uiStroke.Parent=input

    inputHolder.Parent=toAddTo

    local function fire(inputtedText)
        pcall(function()script(inputtedText)end)
    end

    input:GetPropertyChangedSignal("Text"):Connect(function()
        if int then
            input.Text = input.Text:gsub('%D+', '');
        end
    end)

    input.FocusLost:Connect(function()
        if int then
            fire(tonumber(input.Text))
        else
            fire(input.Text)
        end
    end)
end

function lib:CreateBind(bindText,script)
    script=script or function() end
    local toAddTo=game.CoreGui:FindFirstChild(name).Frame.ScrollingFrame
    local bindButton=Instance.new("TextButton")
    bindButton.BackgroundColor3=Color3.fromRGB(32,32,32)
    bindButton.Font=Enum.Font.Gotham
    bindButton.Text=bindText
    bindButton.TextColor3=Color3.fromRGB(220,220,220)
    bindButton.TextScaled=true
    bindButton.AutoButtonColor=false
    bindButton.TextXAlignment=Enum.TextXAlignment.Left
    bindButton.Size=UDim2.new(1,0,0,35)

    local uiCorner=Instance.new("UICorner")
    uiCorner.CornerRadius=UDim.new(0,5)
    uiCorner.Parent=bindButton

    local uiPadding=Instance.new("UIPadding")
    uiPadding.PaddingLeft=UDim.new(0.025, 0)
    uiPadding.PaddingRight=UDim.new(0.025, 0)
    uiPadding.PaddingBottom=UDim.new(0.225, 0)
    uiPadding.PaddingTop=UDim.new(0.225, 0)
    uiPadding.Parent=bindButton

    local bindKey=Instance.new("StringValue")
    bindKey.Name="Binding"
    bindKey.Parent=bindButton
	bindKey.Value=''

    local bindText=Instance.new("TextLabel")
    bindText.AnchorPoint=Vector2.new(0.5,0.5)
    bindText.BackgroundTransparency=1
    bindText.Text="[NONE]"
    bindText.Position=UDim2.new(0.858,0,0.5,0)
    bindText.Size=UDim2.new(0.3,0,0,25)
    bindText.Font=Enum.Font.Gotham
    bindText.TextColor3=Color3.fromRGB(220,220,220)
    bindText.TextScaled=true
    bindText.TextXAlignment=Enum.TextXAlignment.Right
    bindText.Parent=bindButton

    local uiPadding2=Instance.new("UIPadding")
    uiPadding2.PaddingBottom=UDim.new(0.17, 0)
    uiPadding2.PaddingTop=UDim.new(0.17, 0)
    uiPadding2.Parent=bindText
    
    bindButton.Parent=toAddTo

    bindButton.MouseEnter:Connect(function()
        bindButton.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
    end)
    
    bindButton.MouseLeave:Connect(function()
        bindButton.BackgroundColor3 = Color3.fromRGB(32,32,32)
    end)

    local function fire(key)
        pcall(function()script(key)end)
    end
    local configuring
    bindButton.Activated:Connect(function()
        if configuring then configuring = nil end
        configuring = bindButton
        if table.find(bindTable,configuring:FindFirstChildWhichIsA("StringValue").Value) then
            for i,v in pairs(bindTable) do
                if v == configuring:FindFirstChildWhichIsA("StringValue").Value then
                    table.remove(bindTable,i)
                end
            end
        end
        keybind_listening = true
        configuring.TextLabel.Text = "[ . . . ]"
    end)
    local key='[NONE]'
    connectionTable[#connectionTable+1]=UIS.InputBegan:Connect(function(input,typing)
        if typing then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._")) == bindKey.Value then
				if key then
                    pcall(script)
				end
            end
            if not configuring then return end
            if keybind_listening == true then
                if not table.find(bindTable,string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))) then
                    table.insert(bindTable,string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._")))
                    configuring:FindFirstChildWhichIsA("StringValue").Value = string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))
                    configuring.TextLabel.Text = string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))
					key=tostring(input.KeyCode.Name)
					fire(key);
                else
                    configuring.TextLabel.Text = "[TAKEN]"
                end
				keybind_listening=false
                configuring = nil
            end
        end
    end)
end

connectionTable[#connectionTable+1]=game.CoreGui.ChildRemoved:Connect(function(UI)
	if tostring(UI)==name then 
		for i=1,#connectionTable do 
			local connection=connectionTable[i]
			pcall(function()
				connection:Disconnect()
			end);
		end;
	end;
end)
return lib
