local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local Players = game:GetService('Players')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local TabNumber = 1
local FirstTab = true
local Window = nil
local Background = nil
local Name = 'LiquidLibV1'

local KeybindListening = false

local BindTable = {}
local LiquidLibrary = {
    Elements = {},
    Connections = {}
}
local Connections = {}
local BlacklistedKeys = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Left,
    Enum.KeyCode.Down,
    Enum.KeyCode.Right,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Tab,
    Enum.KeyCode.Backspace,
    Enum.KeyCode.Escape
}

if game.CoreGui:FindFirstChild(Name) then
    game.CoreGui[Name]:Destroy()
end

local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end

local function CreateElement(ElementName, ElementFunction)
	LiquidLibrary.Elements[ElementName] = function(...)
		return ElementFunction(...)
	end
end

local function MakeElement(ElementName, ...)
	local NewElement = LiquidLibrary.Elements[ElementName](...)
	return NewElement
end

CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 10)
	})
	return Corner
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
	local Padding = Create("UIPadding", {
		PaddingBottom = UDim.new(Bottom, 0),
		PaddingLeft = UDim.new(Left, 0),
		PaddingRight = UDim.new(Right, 0),
		PaddingTop = UDim.new(Top, 0)
	})
	return Padding
end)

CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {
		Color = Color or Color3.fromRGB(60, 60, 60),
		Thickness = Thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	})
	return Stroke
end)

local function AddConnection(Signal, Function)
    local SignalConnect = Signal:Connect(Function)
    table.insert(LiquidLibrary.Connections, SignalConnect)
    return SignalConnect
end

local function MakeDraggable(DragPoint, Main)
    pcall(function()
        local Dragging, DragInput, MousePos, FramePos = false
        AddConnection(DragPoint.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                MousePos = Input.Position
                FramePos = Main.Position

                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
        AddConnection(DragPoint.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                DragInput = Input
            end
        end)
        AddConnection(UserInputService.InputChanged, function(Input)
            if Input == DragInput and Dragging then
                local Delta = Input.Position - MousePos
                Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
            end
        end)
    end)
end    

function LiquidLibrary:CreateWindow(TitleText)
    if not TitleText then
        TitleText = 'Placeholder'
    end

    Window = Instance.new('ScreenGui')
    Window.DisplayOrder = 25
    Window.Name = Name

    Background = Instance.new('Frame')
    Background.AnchorPoint = Vector2.new(0.5, 0.5)
    Background.Position = UDim2.new(0.5, 0, 0.5, 0)
    Background.Size = UDim2.new(0.22, 0, 0.23, 0)
    Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Background.Name = 'Background'
    Background.Parent = Window

    local DraggableLayer = Instance.new('Frame')
    DraggableLayer.BackgroundTransparency = 1
    DraggableLayer.Size = UDim2.new(1, 0, 0.14, 0)
    DraggableLayer.ZIndex = 2
    DraggableLayer.Parent = Background

    MakeDraggable(DraggableLayer, Background)

    local UICorner = MakeElement('Corner', 0.03, 0)
    UICorner.Parent = Background

    local TitleLabel = Instance.new('TextLabel')
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, 0, 0.14, 0)
    TitleLabel.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextScaled = true
    TitleLabel.Text = TitleText
    TitleLabel.Name = 'Title'
    TitleLabel.Parent = Background

    local UIPadding = MakeElement('Padding', 0.225, 0.03, 0.03, 0.225)
    UIPadding.Parent = TitleLabel

    local SectionList = Instance.new('ScrollingFrame')
    SectionList.BorderSizePixel = 0
    SectionList.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    SectionList.Position = UDim2.new(0, 0, 0.14, 0)
    SectionList.CanvasSize = UDim2.new(0, 0, 0.7, -1)
    SectionList.Size = UDim2.new(0.31, 0, 0.7, 0)
    SectionList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    SectionList.ScrollBarThickness = 8
    SectionList.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
    SectionList.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
    SectionList.ScrollBarImageColor3 = Color3.fromRGB(25, 25, 25)
    SectionList.Name = 'SectionList'
    SectionList.Parent = Background

    local UIListLayout = Instance.new('UIListLayout')
    UIListLayout.Padding = UDim.new(0.04, 0)
    UIListLayout.Parent = SectionList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local PaddingFix = Instance.new('Frame')
    PaddingFix.LayoutOrder = -1
    PaddingFix.BackgroundTransparency = 1
    PaddingFix.Size = UDim2.new(0.001, 0, 0.01, 0)
    PaddingFix.Parent = SectionList

    local PaddingFix = Instance.new('Frame')
    PaddingFix.LayoutOrder = 10000
    PaddingFix.BackgroundTransparency = 1
    PaddingFix.Size = UDim2.new(0.001, 0, 0.01, 0)
    PaddingFix.Parent = SectionList

    local ItemStorage = Instance.new('Frame')
    ItemStorage.BackgroundTransparency = 1
    ItemStorage.Position = UDim2.new(0.31, 0, 0.14, 0)
    ItemStorage.Size = UDim2.new(0.69, 0, 0.86, 0)
    ItemStorage.Parent = Background

    local ProfileArea = Instance.new('Frame')
    ProfileArea.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    ProfileArea.Position = UDim2.new(0, 0, 0.84, 0)
    ProfileArea.Size = UDim2.new(0.31, 0, 0.16, 0)
    ProfileArea.Name = 'ProfileArea'
    ProfileArea.Parent = Background

    local UICorner = MakeElement('Corner', 0.2, 0)
    UICorner.Parent = ProfileArea

    local RoundFix = Instance.new('Frame')
    RoundFix.BorderSizePixel = 0
    RoundFix.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    RoundFix.Size = UDim2.new(1, 0, 0.2, 0)
    RoundFix.Name = 'RoundingFix'
    RoundFix.Parent = ProfileArea

    local RoundFix = Instance.new('Frame')
    RoundFix.BorderSizePixel = 0
    RoundFix.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
    RoundFix.Position = UDim2.new(0.8, 0, 0, 0)
    RoundFix.Size = UDim2.new(0.2, 0, 1, 0)
    RoundFix.Name = 'RoundingFix'
    RoundFix.Parent = ProfileArea

    local Separator = Instance.new('Frame')
    Separator.BorderSizePixel = 0
    Separator.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    Separator.Position = UDim2.new(0, 0, 0.14, 0)
    Separator.Size = UDim2.new(1, 0, 0, 1)
    Separator.ZIndex = 15
    Separator.Name = 'Separator'
    Separator.Parent = Background

    local Separator = Instance.new('Frame')
    Separator.BorderSizePixel = 0
    Separator.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    Separator.Position = UDim2.new(0.31, 0, 0.14, 0)
    Separator.Size = UDim2.new(0, 1, 0.86, 0)
    Separator.ZIndex = 15
    Separator.Name = 'Separator'
    Separator.Parent = Background

    local Separator = Instance.new('Frame')
    Separator.BorderSizePixel = 0
    Separator.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    Separator.Position = UDim2.new(0, 0, 0.84, 0)
    Separator.Size = UDim2.new(0.31, 0, 0, 1)
    Separator.ZIndex = 15
    Separator.Name = 'Separator'
    Separator.Parent = Background

    local TabFunction = {}
    function TabFunction:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or 'Tab'

        local TabButton = Instance.new('TextButton')
        TabButton.BackgroundTransparency = 1
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Size = UDim2.new(1, 0, 0.1, 0)
        TabButton.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.ZIndex = TabNumber
        TabButton.TextTransparency = 0.4
        TabButton.TextScaled = true
        TabButton.Text = TabConfig.Name
        TabButton.Name = TabConfig.Name
        TabButton.Parent = SectionList

        local Container = Instance.new('ScrollingFrame')
        Container.BorderSizePixel = 0
        Container.BackgroundTransparency = 1
        Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Container.Position = UDim2.new(0, 0, 0, 0)
        Container.CanvasSize = UDim2.new(0, 0, 0.86, 0)
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Container.ScrollBarThickness = 0
        Container.Name = 'Container'
        Container.Parent = ItemStorage
        Container.Visible = false

        local UIListLayout = Instance.new('UIListLayout')
        UIListLayout.Padding = UDim.new(0.025, 0)
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = Container

        local PaddingFix = Instance.new('Frame')
        PaddingFix.LayoutOrder = -1
        PaddingFix.BackgroundTransparency = 1
        PaddingFix.Size = UDim2.new(0.001, 0, 0.0115, 0)
        PaddingFix.Parent = Container
    
        local PaddingFix = Instance.new('Frame')
        PaddingFix.LayoutOrder = 10000
        PaddingFix.BackgroundTransparency = 1
        PaddingFix.Size = UDim2.new(0.001, 0, 0.0115, 0)
        PaddingFix.Parent = Container

        TabNumber += 1

        if FirstTab then
            FirstTab = false
            TabButton.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TabButton.TextTransparency = 0

            Container.Visible = true
        end

        local UIPadding = Instance.new('UIPadding')
        UIPadding.PaddingTop = UDim.new(0.085, 0)
        UIPadding.PaddingBottom = UDim.new(0.085, 0)
        UIPadding.PaddingLeft = UDim.new(0.11, 0)
        UIPadding.PaddingRight = UDim.new(0.11, 0)
        UIPadding.Parent = TabButton

        AddConnection(TabButton.MouseButton1Click, function()
            for _, Tab in next, SectionList:GetChildren() do
                if Tab:IsA('TextButton') then
                    Tab.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
                    TweenService:Create(Tab, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
                end
            end
            for _, ItemContainer in next, ItemStorage:GetChildren() do
                ItemContainer.Visible = false
            end

            Container.Visible = true
            TabButton.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TweenService:Create(TabButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        end)

        local ElementFunction = {}
        
        function ElementFunction:AddLabel(Text)
            local TextLabel = Instance.new('TextLabel')
            TextLabel.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            TextLabel.Size = UDim2.new(0.925, 0, 0.1, 0)
            TextLabel.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Text = Text
            TextLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
            TextLabel.TextScaled = true

            local UICorner = MakeElement('Corner', 0.2, 0)
            UICorner.Parent = TextLabel

            local UIPadding = MakeElement('Padding', 0.175, 0.025, 0.025, 0.175)
            UIPadding.Parent = TextLabel

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = TextLabel

            TextLabel.Parent = Container
        end

        function ElementFunction:AddParagraph(Title, Content)
            Title = Title or 'Title'
            Content = Content or 'Content'

            local BackFrame = Instance.new('Frame')
            BackFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            BackFrame.Size = UDim2.new(0.925, 0, 0.175, 0)

            local UICorner = MakeElement('Corner', 0.125, 0)
            UICorner.Parent = BackFrame

            local UIPadding = MakeElement('Padding', 0.1, 0.025, 0.025, 0.1)
            UIPadding.Parent = BackFrame

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = BackFrame

            local TitleText = Instance.new('TextLabel')
            TitleText.BackgroundTransparency = 1
            TitleText.Size = UDim2.new(1, 0, 0.5, 0)
            TitleText.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TitleText.TextXAlignment = Enum.TextXAlignment.Left
            TitleText.TextYAlignment = Enum.TextYAlignment.Bottom
            TitleText.Text = Title
            TitleText.TextColor3 = Color3.fromRGB(245, 245, 245)
            TitleText.TextScaled = true
            TitleText.Parent = BackFrame

            local UIPadding = MakeElement('Padding', 0, 0, 0, 0.05)
            UIPadding.Parent = TitleText

            local UITextSizeConstraint = Instance.new('UITextSizeConstraint')
            UITextSizeConstraint.MaxTextSize = 18
            UITextSizeConstraint.Parent = TitleText

            local ContentText = Instance.new('TextLabel')
            ContentText.BackgroundTransparency = 1
            ContentText.Position = UDim2.new(0, 0, 0.3, 0)
            ContentText.Size = UDim2.new(0.925, 0, 0.7, 0)
            ContentText.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
            ContentText.TextXAlignment = Enum.TextXAlignment.Left
            ContentText.TextYAlignment = Enum.TextYAlignment.Top
            ContentText.Text = Content
            ContentText.TextColor3 = Color3.fromRGB(200, 200, 200)
            ContentText.TextScaled = true
            ContentText.Parent = BackFrame

            local UIPadding = MakeElement('Padding', 0, 0, 0, 0.325)
            UIPadding.Parent = ContentText

            local UITextSizeConstraint = Instance.new('UITextSizeConstraint')
            UITextSizeConstraint.MaxTextSize = 14
            UITextSizeConstraint.Parent = ContentText

            BackFrame.Parent = Container
        end

        function ElementFunction:AddSection(Title)
            Title = Title or 'Title'

            local TitleText = Instance.new('TextLabel')
            TitleText.BackgroundTransparency = 1
            TitleText.Size = UDim2.new(0.925, 0, 0.1, 0)
            TitleText.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            TitleText.TextXAlignment = Enum.TextXAlignment.Left
            TitleText.TextYAlignment = Enum.TextYAlignment.Bottom
            TitleText.Text = Title
            TitleText.TextColor3 = Color3.fromRGB(150, 150, 150)
            TitleText.TextScaled = true

            local UIPadding = MakeElement('Padding', 0.1, 0.015, 0.015, 0.2)
            UIPadding.Parent = TitleText

            local UITextSizeConstraint = Instance.new('UITextSizeConstraint')
            UITextSizeConstraint.MaxTextSize = 15
            UITextSizeConstraint.Parent = TitleText

            TitleText.Parent = Container
        end

        function ElementFunction:AddButton(ButtonConfig)
            ButtonConfig = ButtonConfig or {}
            ButtonConfig.Name = ButtonConfig.Name or 'Button'
            ButtonConfig.Callback = ButtonConfig.Callback or function() end

            local TextButton = Instance.new('TextButton')
            TextButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
            TextButton.Size = UDim2.new(0.925, 0, 0.1, 0)
            TextButton.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            TextButton.TextXAlignment = Enum.TextXAlignment.Left
            TextButton.Text = ButtonConfig.Name
            TextButton.AutoButtonColor = false
            TextButton.TextColor3 = Color3.fromRGB(245, 245, 245)
            TextButton.TextScaled = true

            local UICorner = MakeElement('Corner', 0.2, 0)
            UICorner.Parent = TextButton

            local UIPadding = MakeElement('Padding', 0.175, 0.025, 0.025, 0.175)
            UIPadding.Parent = TextButton

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = TextButton

            local ImageLabel = Instance.new('ImageLabel')
            ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Image = 'rbxassetid://18249179109'
            ImageLabel.ImageColor3 = Color3.fromRGB(245, 245, 245)
            ImageLabel.Position = UDim2.new(0.965, 0, 0.5, 0)
            ImageLabel.Size = UDim2.new(0.75, 0, 0.82, 0)
            ImageLabel.Parent = TextButton

            local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
            UIAspectRatioConstraint.AspectRatio = 1
            UIAspectRatioConstraint.Parent = ImageLabel

            TextButton.Parent = Container

            AddConnection(TextButton.MouseEnter, function()
                TweenService:Create(TextButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
            end)

            AddConnection(TextButton.MouseLeave, function()
                TweenService:Create(TextButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(39, 39, 39)}):Play()
            end)

            AddConnection(TextButton.MouseButton1Up, function()
                TweenService:Create(TextButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
                spawn(function()
                    ButtonConfig.Callback()
                end)
            end)

            AddConnection(TextButton.MouseButton1Down, function()
                TweenService:Create(TextButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
        end

        function ElementFunction:AddToggle(ToggleConfig)
            ToggleConfig = ToggleConfig or {}
            ToggleConfig.Name = ToggleConfig.Name or 'Toggle'
            ToggleConfig.Default = ToggleConfig.Default or false
            ToggleConfig.Callback = ToggleConfig.Callback or function() end

            local Toggle = {
                Value = ToggleConfig.Default
            }

            local TextLabel = Instance.new('TextLabel')
            TextLabel.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
            TextLabel.Size = UDim2.new(0.925, 0, 0.13, 0)
            TextLabel.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Text = ToggleConfig.Name
            TextLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
            TextLabel.TextScaled = true

            local UICorner = MakeElement('Corner', 0.15, 0)
            UICorner.Parent = TextLabel

            local UIPadding = MakeElement('Padding', 0.2468, 0.025, 0.025, 0.2468)
            UIPadding.Parent = TextLabel

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = TextLabel

            local ToggleButton = Instance.new('TextButton')
            ToggleButton.Text = ''
            ToggleButton.BackgroundColor3 = Toggle.Value and Color3.fromRGB(59, 112, 234) or Color3.fromRGB(35, 35, 35)
            ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
            ToggleButton.AutoButtonColor = false
            ToggleButton.BackgroundTransparency = 0
            ToggleButton.Position = UDim2.new(0.94, 0, 0.5, 0)
            ToggleButton.Size = UDim2.new(1, 0, 1.275, 0)
            ToggleButton.Parent = TextLabel

            local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
            UIAspectRatioConstraint.AspectRatio = 1
            UIAspectRatioConstraint.Parent = ToggleButton
            
            local UICorner = MakeElement('Corner', 0.25, 0)
            UICorner.Parent = ToggleButton

            local UIPadding = MakeElement('Padding', 0.175, 0.025, 0.025, 0.175)
            UIPadding.Parent = ToggleButton

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = ToggleButton

            local CheckImage = Instance.new('ImageLabel')
            CheckImage.AnchorPoint = Vector2.new(0.5, 0.5)
            CheckImage.BackgroundTransparency = 1
            CheckImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
            CheckImage.Size = Toggle.Value and UDim2.new(1.25, 0, 1.25, 0) or UDim2.new(0, 0, 0, 0)
            CheckImage.Position = UDim2.new(0.5, 0, 0.5, 0)
            CheckImage.Image = 'rbxassetid://18250342163'
            CheckImage.Parent = ToggleButton

            local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
            UIAspectRatioConstraint.AspectRatio = 1
            UIAspectRatioConstraint.Parent = CheckImage

            TextLabel.Parent = Container

            AddConnection(ToggleButton.MouseButton1Up, function()
                spawn(function()
                    Toggle.Value = not Toggle.Value
                    ToggleConfig.Callback(Toggle.Value)
                    TweenService:Create(ToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Toggle.Value and Color3.fromRGB(59, 112, 234) or Color3.fromRGB(35, 35, 35)}):Play()
                    TweenService:Create(CheckImage, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = Toggle.Value and UDim2.new(1.2, 0, 1.2, 0) or UDim2.new(0, 0, 0, 0), ImageTransparency = Toggle.Value and 0 or 1}):Play()
                end)
            end)
        end

        function ElementFunction:AddBind(BindConfig)
            BindConfig = BindConfig or {}
            BindConfig.Name = BindConfig.Name or 'Bind'
            BindConfig.Default = BindConfig.Default or false
            BindConfig.Callback = BindConfig.Callback or function() end

            local Bind = {
                Value = BindConfig.Default and BindConfig.Default.Name or nil,
                Binding = false
            }

            local BindButton = Instance.new('TextButton')
            BindButton.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
            BindButton.Size = UDim2.new(0.925, 0, 0.1, 0)
            BindButton.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            BindButton.TextXAlignment = Enum.TextXAlignment.Left
            BindButton.Text = BindConfig.Name
            BindButton.AutoButtonColor = false
            BindButton.TextColor3 = Color3.fromRGB(245, 245, 245)
            BindButton.TextScaled = true

            local UICorner = MakeElement('Corner', 0.2, 0)
            UICorner.Parent = BindButton

            local UIPadding = MakeElement('Padding', 0.175, 0.025, 0.025, 0.175)
            UIPadding.Parent = BindButton

            local UIStroke = MakeElement('Stroke')
            UIStroke.Parent = BindButton

            local BindText = Instance.new('TextLabel')
            BindText.AnchorPoint = Vector2.new(0, 0.5)
            BindText.TextColor3 = Color3.fromRGB(215, 215, 215)
            BindText.BackgroundTransparency = 1
            BindText.Text = BindConfig.Default and `[ {BindConfig.Default.Name} ]` or `[  ]`
            BindText.Position = UDim2.new(0.57, 0, 0.5, 0)
            BindText.Size = UDim2.new(0.425, 0, 0.82, 0)
            BindText.TextXAlignment = Enum.TextXAlignment.Right
            BindText.FontFace = Font.new(Font.fromEnum(Enum.Font.Montserrat).Family, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            BindText.TextScaled = true
            BindText.Parent = BindButton

            BindButton.Parent = Container

            AddConnection(UserInputService.InputBegan, function(Input)
                if UserInputService:GetFocusedTextBox() then return end
                if (Input.KeyCode.Name == Bind.Value) and not Bind.Binding then
                    BindConfig.Callback()
                elseif Bind.Binding then
                    local Key
                    pcall(function()
                        if not CheckKey(BlacklistedKeys, Input.KeyCode) then
                            Key = Input.KeyCode
                        end
                    end)
                    Key = Key or Bind.Value

                    Bind.Binding = false
					Bind.Value = Key or Bind.Value
					Bind.Value = Bind.Value.Name or Bind.Value
                    -- bl mousebuttons
					BindText.Text = `[ {Bind.Value} ]` 
                end
            end)

            AddConnection(BindButton.MouseEnter, function()
                TweenService:Create(BindButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
            end)

            AddConnection(BindButton.MouseLeave, function()
                TweenService:Create(BindButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(39, 39, 39)}):Play()
            end)

            AddConnection(BindButton.MouseButton1Up, function()
                TweenService:Create(BindButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
                Bind.Binding = true
            end)

            AddConnection(BindButton.MouseButton1Down, function()
                TweenService:Create(BindButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
        end

        return ElementFunction
    end

    Window.Parent = game.CoreGui
    return TabFunction
end

return LiquidLibrary
