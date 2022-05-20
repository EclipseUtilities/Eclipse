local window,frame,name = nil,nil,"Eclipse"
local keybind_listening = false
local UIS = game:GetService("UserInputService")
local bindTable,lib = {},{}

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == name then
        v:Destroy()
    end
end

function lib:CreateWindow()
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0,10)
    local uiCorner2 = uiCorner:Clone()
    local dropShadow = Instance.new("ImageLabel")
    dropShadow.Image = "http://www.roblox.com/asset/?id=6147985449"
    dropShadow.Size = UDim2.new(1,30,1,30)
    dropShadow.AnchorPoint = Vector2.new(0.5,0.5)
    dropShadow.Position = UDim2.new(0.5,0,0.5,0)
    dropShadow.ImageColor3 = Color3.fromRGB(39,39,39)
    dropShadow.BorderSizePixel = 0
    dropShadow.BackgroundTransparency = 1
    dropShadow.ScaleType = Enum.ScaleType.Slice
    dropShadow.SliceCenter = Rect.new(20, 20, 280, 280)
    dropShadow.SliceScale = 1
    local text = Instance.new("TextLabel")
    text.BackgroundTransparency = 1 
    text.AnchorPoint = Vector2.new(0.5,0.5)
    text.Size = UDim2.new(0.8,0,0.05,0)
    text.Position = UDim2.new(0.5,0,0.05,0)
    text.TextColor3 = Color3.fromRGB(127, 127, 127)
    text.Font = Enum.Font.GothamSemibold
    text.TextScaled = true
    text.Text = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.AnchorPoint = Vector2.new(0.5,0.5)
    scrollingFrame.Position = UDim2.new(0.5,0,0.54,0)
    scrollingFrame.Size = UDim2.new(0.96,0,0.88,0)
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(140,140,140)
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.BorderSizePixel = 0
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,3)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scrollingFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0,3)
    padding.Parent = scrollingFrame
    local scrollingFrameParent = Instance.new("Frame")
    scrollingFrameParent.AnchorPoint = Vector2.new(0.5,0.5)
    scrollingFrameParent.Position = UDim2.new(0.5,0,0.54,0) 
    scrollingFrameParent.Size = UDim2.new(0.96,0,0.88,0)
    scrollingFrameParent.BackgroundColor3 = Color3.fromRGB(45,45,45)
    uiCorner2.Parent = scrollingFrameParent
    window = Instance.new("ScreenGui")
    window.IgnoreGuiInset = true
    window.ResetOnSpawn = false
    window.Name = name
    frame = Instance.new("Frame")
    uiCorner.Parent = frame
    dropShadow.Parent = frame
    text.Parent = frame
    scrollingFrameParent.Parent = frame
    scrollingFrame.Parent = frame
    frame.Parent = window
    frame.Size = UDim2.new(0.25,0,0.35,0)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    frame.Draggable = true
    frame.Selectable = true
    frame.Active = true
    frame.BackgroundColor3 = Color3.fromRGB(39,39,39)
    window.Parent = game:GetService("CoreGui")
    
    scrollingFrame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
    scrollingFrame.ChildAdded:Connect(function(child)
        scrollingFrame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + child.Size.Y.Offset + 6 + layout.Padding.Offset)
    end)
end

function lib:Button(text,toRun)
    toRun = toRun or function() end
    local toAddTo = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame
    local button = Instance.new("TextButton")
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(152,152,152)
    button.Size = UDim2.new(0.925,0,0,27)
    button.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    button.Text = text
    button.AutoButtonColor = false
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,5)
    corner.Parent = button
    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0.15,0)
    padding.PaddingTop = UDim.new(0.15,0)
    padding.Parent = button
    button.Parent = toAddTo
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    button.MouseLeave:Connect(function()
       button.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    end)
    
    button.MouseButton1Click:Connect(function()
        pcall(toRun)
    end)
end

function lib:Toggle(toggleText,toRun,default)
    local enabled = false
	default=default or false
    toRun = toRun or function() end
    local toAddTo = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame
    local toggle = Instance.new("TextLabel")
    toggle.Font = Enum.Font.Gotham
    toggle.TextScaled = true
    toggle.TextColor3 = Color3.fromRGB(152,152,152)
    toggle.Size = UDim2.new(0.925,0,0,27)
    toggle.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    toggle.TextXAlignment = Enum.TextXAlignment.Left
    toggle.Text = toggleText
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,5)
    corner.Parent = toggle
    local corner2 = corner:Clone()
    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0.15,0)
    padding.PaddingTop = UDim.new(0.15,0)
    padding.PaddingLeft = UDim.new(0.025,0)
    padding.PaddingRight = UDim.new(0.3,0)
    padding.Parent = toggle
    local toggleButton = Instance.new("TextButton")
    toggleButton.AutoButtonColor = false
    toggleButton.Size = UDim2.new(0,19,0,19)
    toggleButton.AnchorPoint = Vector2.new(0.5,0.5)
    toggleButton.Position = UDim2.new(1.39,0,0.5,0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
    toggleButton.Text = ""
    corner2.Parent = toggleButton
    toggleButton.Parent = toggle
    toggle.Parent = toAddTo
    
    toggleButton.MouseEnter:Connect(function()
        if toggleButton.BackgroundColor3 ~= Color3.fromRGB(65, 126, 71) then
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)
    
    toggleButton.MouseLeave:Connect(function()
        if toggleButton.BackgroundColor3 ~= Color3.fromRGB(65, 126, 71) then
            toggleButton.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
        end
    end)
    
    local function fire()
        enabled = not enabled
        toggleButton.BackgroundColor3 = enabled and Color3.fromRGB(65, 126, 71) or Color3.fromRGB(61,61,61)
        pcall(toRun, enabled)
    end
	if default then 
		pcall(toRun, enabled)
	end;
    toggleButton.MouseButton1Click:Connect(fire)
end

function lib:Input(placeHolderText,uiName,playerInput)
    local toAddTo = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame
    local holder = Instance.new("TextLabel")
    holder.Size = UDim2.new(0.925,0,0,27)
    holder.Name = uiName
    holder.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,5)
    corner.Parent = holder
    local corner2 = corner:Clone()
    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0.15,0)
    padding.PaddingTop = UDim.new(0.15,0)
    local textBox = Instance.new("TextBox")
    textBox.AnchorPoint = Vector2.new(0.5,0.5)
    textBox.BackgroundColor3 = Color3.fromRGB(47,47,47)
    textBox.Position = UDim2.new(0.5,0,0.5,0)
    textBox.Size = UDim2.new(0.981,0,0.757,0)
    textBox.Font = Enum.Font.Gotham
    textBox.TextScaled = true
    textBox.PlaceholderColor3 = Color3.fromRGB(81,81,81)
    textBox.TextColor3 = Color3.fromRGB(152,152,152)
    textBox.PlaceholderText = placeHolderText
    holder.Text = ""
    textBox.Text = ""
    corner2.Parent = textBox
    padding.Parent = textBox
    textBox.Parent = holder
    holder.Parent = toAddTo
    
    if playerInput == true then
        pcall(function()
            local players = game:GetService("Players")

            local function getPlayer(user)
            	user = user:lower()
            	for _,plr in ipairs(players:GetPlayers()) do
            		if user == plr.Name:lower():sub(1, #user) then
            			return plr
            		end
            	end
            	return nil
            end
            
            textBox:GetPropertyChangedSignal("Text"):Connect(function()
            	textBox.Text = textBox.Text:sub(1,35)
            end)
            
            textBox.FocusLost:Connect(function()
            	if getPlayer(textBox.Text) ~= nil and textBox.Text ~= "" then
            		textBox.Text = tostring(getPlayer(textBox.Text))
            	end
            end)
        end)
    end
end

function lib:Bind(bindText,toRun)
    toRun = toRun or function() end
    local toAddTo = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame
    local bind = Instance.new("TextButton")
    bind.Font = Enum.Font.Gotham
    bind.AutoButtonColor = false
    bind.TextScaled = true
    bind.TextColor3 = Color3.fromRGB(152,152,152)
    bind.Size = UDim2.new(0.925,0,0,27)
    bind.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    bind.TextXAlignment = Enum.TextXAlignment.Left
    bind.Name = bindText
    bind.Text = bindText..": NONE"
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,5)
    corner.Parent = bind
    local bindKey = Instance.new("StringValue")
    bindKey.Value = ""
    bindKey.Name = "Binding"
    bindKey.Parent = bind
    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0.15,0)
    padding.PaddingTop = UDim.new(0.15,0)
    padding.PaddingLeft = UDim.new(0.025,0)
    padding.PaddingRight = UDim.new(0.025,0)
    padding.Parent = bind
    bind.Parent = toAddTo
    
    bind.MouseEnter:Connect(function()
        bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    bind.MouseLeave:Connect(function()
        bind.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    end)
    
    local function fire()
        pcall(toRun)
    end
    local configuring
    bind.Activated:Connect(function()
        if configuring then configuring = nil end
        configuring = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame:FindFirstChild(bind.Name)
        if table.find(bindTable,configuring:FindFirstChildWhichIsA("StringValue").Value) then
            for i,v in pairs(bindTable) do
                if v == configuring:FindFirstChildWhichIsA("StringValue").Value then
                    table.remove(bindTable,i)
                end
            end
        end
        keybind_listening = true
        configuring.Text = bindText..": [ . . . ]"
    end)
    
    UIS.InputBegan:Connect(function(input,typing)
        if typing then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._")) == bindKey.Value then
                fire()
            end
            if not configuring then return end
            if keybind_listening == true then
                if not table.find(bindTable,string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))) then
                    table.insert(bindTable,string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._")))
                    configuring:FindFirstChildWhichIsA("StringValue").Value = string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))
                    configuring.Text = bindText..": "..string.sub(tostring(input.KeyCode), string.len("Enum.KeyCode._"))
                else
                    configuring.Text = bindText..": NONE [TAKEN]"
                end
                configuring = nil
            end
        end
    end)
end

function lib:Section(sectionText,top)
    local toAddTo = game:GetService("CoreGui"):FindFirstChild(name).Frame.ScrollingFrame
    local text = Instance.new("TextLabel")
    text.Font = Enum.Font.GothamSemibold
    text.TextScaled = true
    text.TextColor3 = Color3.fromRGB(175,175,175)
    text.BackgroundTransparency = 1
    text.Text = sectionText
    local padding = Instance.new("UIPadding")
    if top == true then
        padding.PaddingTop = UDim.new(0.15,0)
        text.Size = UDim2.new(0.925,0,0,27)
    else
        padding.PaddingTop = UDim.new(0.4,0)
        text.Size = UDim2.new(0.925,0,0,40)
    end
    padding.PaddingBottom = UDim.new(0.12,0)
    padding.Parent = text
    text.Parent = toAddTo
end

return lib
