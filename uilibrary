local window,frame,name = nil,nil,"wRlwH7znJU5zekP"

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == name then
        v:Destroy()
    end
end

function createWindow()
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

function createButton(text,toRun)
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

function createToggle(toggleText,toRun)
    local enabled = false
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
    
    toggleButton.MouseButton1Click:Connect(fire)
end

function createSection(sectionText,top)
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
