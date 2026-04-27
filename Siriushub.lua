local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.CurrentTheme = {
    MainColor = Color3.fromRGB(15, 15, 15),
    SideColor = Color3.fromRGB(25, 25, 25),
    TopColor = Color3.fromRGB(20, 20, 20),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(0, 180, 80)
}

function Library:Init()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Fexaw_Ultimate_Library_V3"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 520, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    MainFrame.BackgroundColor3 = _G.CurrentTheme.MainColor
    MainFrame.Visible = false
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local SidePanel = Instance.new("ScrollingFrame")
    SidePanel.Name = "SidePanel"
    SidePanel.Parent = MainFrame
    SidePanel.Size = UDim2.new(0, 150, 1, -10)
    SidePanel.Position = UDim2.new(0, 5, 0, 5)
    SidePanel.BackgroundColor3 = _G.CurrentTheme.SideColor
    SidePanel.BorderSizePixel = 0
    SidePanel.ScrollBarThickness = 0
    SidePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    SidePanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", SidePanel).CornerRadius = UDim.new(0, 6)
    
    local SideLayout = Instance.new("UIListLayout", SidePanel)
    SideLayout.Padding = UDim.new(0, 5)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = ScreenGui
    TopBar.Size = UDim2.new(0, 350, 0, 40)
    TopBar.Position = UDim2.new(0.5, -175, 0.1, 0)
    TopBar.BackgroundColor3 = _G.CurrentTheme.TopColor
    TopBar.BorderSizePixel = 0
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)
    
    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Name = "ContainerHolder"
    ContainerHolder.Parent = MainFrame
    ContainerHolder.Size = UDim2.new(1, -165, 1, -50)
    ContainerHolder.Position = UDim2.new(0, 160, 0, 45)
    ContainerHolder.BackgroundTransparency = 1

    local ConfirmOverlay = Instance.new("Frame")
    ConfirmOverlay.Name = "ConfirmOverlay"
    ConfirmOverlay.Parent = ScreenGui
    ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
    ConfirmOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    ConfirmOverlay.BackgroundTransparency = 1
    ConfirmOverlay.Visible = false
    ConfirmOverlay.ZIndex = 1000

    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Name = "ConfirmFrame"
    ConfirmFrame.Parent = ConfirmOverlay
    ConfirmFrame.Size = UDim2.new(0, 280, 0, 140)
    ConfirmFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ConfirmFrame.BorderSizePixel = 0
    Instance.new("UICorner", ConfirmFrame)
    
    local ConfirmStroke = Instance.new("UIStroke", ConfirmFrame)
    ConfirmStroke.Thickness = 2
    ConfirmStroke.Color = Color3.fromRGB(255, 255, 255)

    local ConfirmLabel = Instance.new("TextLabel")
    ConfirmLabel.Parent = ConfirmFrame
    ConfirmLabel.Size = UDim2.new(1, 0, 0, 70)
    ConfirmLabel.BackgroundTransparency = 1
    ConfirmLabel.Text = "Are you sure you want to close the menu?"
    ConfirmLabel.TextColor3 = Color3.new(1, 1, 1)
    ConfirmLabel.Font = Enum.Font.SourceSansBold
    ConfirmLabel.TextSize = 16
    ConfirmLabel.TextWrapped = true

    local YesButton = Instance.new("TextButton")
    YesButton.Name = "YesButton"
    YesButton.Parent = ConfirmFrame
    YesButton.Size = UDim2.new(0.4, 0, 0, 35)
    YesButton.Position = UDim2.new(0.05, 0, 0.65, 0)
    YesButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    YesButton.Text = "Yes"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", YesButton)

    local NoButton = Instance.new("TextButton")
    NoButton.Name = "NoButton"
    NoButton.Parent = ConfirmFrame
    NoButton.Size = UDim2.new(0.4, 0, 0, 35)
    NoButton.Position = UDim2.new(0.55, 0, 0.65, 0)
    NoButton.Text = "No"
    NoButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", NoButton)

    _G.UpdateMenuVisuals = function()
        MainFrame.BackgroundColor3 = _G.CurrentTheme.MainColor
        SidePanel.BackgroundColor3 = _G.CurrentTheme.SideColor
        TopBar.BackgroundColor3 = _G.CurrentTheme.TopColor
    end

    local DragButton = Instance.new("TextButton")
    DragButton.Name = "DragButton"
    DragButton.Parent = TopBar
    DragButton.Size = UDim2.new(0, 40, 1, 0)
    DragButton.BackgroundTransparency = 1
    DragButton.Text = "::"
    DragButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DragButton.TextSize = 20
    DragButton.Font = Enum.Font.SourceSansBold

    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Parent = TopBar
    OpenButton.Size = UDim2.new(1, -50, 1, 0)
    OpenButton.Position = UDim2.new(0, 45, 0, 0)
    OpenButton.BackgroundTransparency = 1
    OpenButton.Text = "FEXAW HUB | ALL SYSTEMS ONLINE"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 16
    OpenButton.Font = Enum.Font.SourceSansBold
    OpenButton.TextXAlignment = Enum.TextXAlignment.Left

    local Dragging = false
    local DragStart, StartPosTop, StartPosMain
    DragButton.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPosTop = TopBar.Position
            StartPosMain = MainFrame.Position
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = Input.Position - DragStart
            TopBar.Position = UDim2.new(StartPosTop.X.Scale, StartPosTop.X.Offset + Delta.X, StartPosTop.Y.Scale, StartPosTop.Y.Offset + Delta.Y)
            MainFrame.Position = UDim2.new(StartPosMain.X.Scale, StartPosMain.X.Offset + Delta.X, StartPosMain.Y.Scale, StartPosMain.Y.Offset + Delta.Y)
        end
    end)

    OpenButton.MouseButton1Click:Connect(function()
        if not MainFrame.Visible then
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 520, 0, 380)}):Play()
        else
            local CloseTween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
            CloseTween:Play()
            CloseTween.Completed:Connect(function()
                if MainFrame.Size.Y.Offset < 10 then MainFrame.Visible = false end
            end)
        end
    end)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 7)
    CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", CloseButton)

    CloseButton.MouseButton1Click:Connect(function()
        ConfirmOverlay.Visible = true
        TweenService:Create(ConfirmOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
    end)

    NoButton.MouseButton1Click:Connect(function()
        TweenService:Create(ConfirmOverlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.wait(0.2)
        ConfirmOverlay.Visible = false
    end)

    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    function Library:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = SidePanel
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", TabButton)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Parent = ContainerHolder
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 2
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 5)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContainerHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(SidePanel:GetChildren()) do
                if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
            end
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)

        local TabObject = {}
        function TabObject:CreateCategory(CategoryName)
            local MainCategoryFrame = Instance.new("Frame")
            MainCategoryFrame.Parent = TabContent
            MainCategoryFrame.Size = UDim2.new(1, -10, 0, 0)
            MainCategoryFrame.AutomaticSize = Enum.AutomaticSize.Y
            MainCategoryFrame.BackgroundTransparency = 1
            Instance.new("UIListLayout", MainCategoryFrame).Padding = UDim.new(0, 3)

            local CategoryButton = Instance.new("TextButton")
            CategoryButton.Parent = MainCategoryFrame
            CategoryButton.Size = UDim2.new(1, 0, 0, 30)
            CategoryButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            CategoryButton.Text = "v " .. CategoryName .. " v"
            CategoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CategoryButton.Font = Enum.Font.SourceSansBold
            Instance.new("UICorner", CategoryButton)

            local ItemsFrame = Instance.new("Frame")
            ItemsFrame.Parent = MainCategoryFrame
            ItemsFrame.Size = UDim2.new(1, 0, 0, 0)
            ItemsFrame.AutomaticSize = Enum.AutomaticSize.Y
            ItemsFrame.BackgroundTransparency = 1
            ItemsFrame.Visible = false
            Instance.new("UIListLayout", ItemsFrame).Padding = UDim.new(0, 3)

            CategoryButton.MouseButton1Click:Connect(function()
                ItemsFrame.Visible = not ItemsFrame.Visible
                CategoryButton.Text = (ItemsFrame.Visible and "^ " or "v ") .. CategoryName .. (ItemsFrame.Visible and " ^" or " v")
            end)

            local CategoryObject = {}
            function CategoryObject:AddToggle(ToggleText, Callback)
                local IsActive = false
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Parent = ItemsFrame
                ToggleButton.Size = UDim2.new(1, 0, 0, 32)
                ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ToggleButton.Text = ToggleText
                ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButton.Font = Enum.Font.SourceSans
                Instance.new("UICorner", ToggleButton)
                
                ToggleButton.MouseButton1Click:Connect(function()
                    IsActive = not IsActive
                    ToggleButton.BackgroundColor3 = IsActive and _G.CurrentTheme.AccentColor or Color3.fromRGB(45, 45, 45)
                    Callback(IsActive)
                end)
            end

            function CategoryObject:AddButton(ButtonText, Callback)
                local Button = Instance.new("TextButton")
                Button.Parent = ItemsFrame
                Button.Size = UDim2.new(1, 0, 0, 32)
                Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Button.Text = ButtonText
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.SourceSans
                Instance.new("UICorner", Button)
                Button.MouseButton1Click:Connect(Callback)
            end

            return CategoryObject
        end
        return TabObject
    end
    return Library
end
return Library
