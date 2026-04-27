local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function Library:Init()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Fexaw_Official_Lib"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 520, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = false
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = ScreenGui
    TopBar.Size = UDim2.new(0, 350, 0, 40)
    TopBar.Position = UDim2.new(0.5, -175, 0.1, 0)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TopBar.BackgroundTransparency = 0.2
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)
    
    local TopStroke = Instance.new("UIStroke", TopBar)
    TopStroke.Thickness = 2

    local SidePanel = Instance.new("ScrollingFrame")
    SidePanel.Name = "SidePanel"
    SidePanel.Parent = MainFrame
    SidePanel.Size = UDim2.new(0, 150, 1, -10)
    SidePanel.Position = UDim2.new(0, 5, 0, 5)
    SidePanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SidePanel.BorderSizePixel = 0
    SidePanel.ScrollBarThickness = 0
    SidePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    SidePanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", SidePanel).CornerRadius = UDim.new(0, 6)
    Instance.new("UIListLayout", SidePanel).Padding = UDim.new(0, 5)

    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Name = "ContainerHolder"
    ContainerHolder.Parent = MainFrame
    ContainerHolder.Size = UDim2.new(1, -165, 1, -50)
    ContainerHolder.Position = UDim2.new(0, 160, 0, 45)
    ContainerHolder.BackgroundTransparency = 1

    local ThemeColor = Color3.fromRGB(0, 120, 255)
    local RainbowEnabled = true

    task.spawn(function()
        local Hue = 0
        while true do
            if RainbowEnabled then
                local Rainbow = Color3.fromHSV(Hue, 1, 1)
                MainStroke.Color = Rainbow
                TopStroke.Color = Rainbow
                Hue = Hue + 0.005
                if Hue > 1 then Hue = 0 end
            else
                MainStroke.Color = ThemeColor
                TopStroke.Color = ThemeColor
            end
            task.wait(0.01)
        end
    end)

    local DragButton = Instance.new("TextButton")
    DragButton.Parent = TopBar
    DragButton.Size = UDim2.new(0, 40, 1, 0)
    DragButton.BackgroundTransparency = 1
    DragButton.Text = "::"
    DragButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DragButton.TextSize = 20
    DragButton.Font = Enum.Font.SourceSansBold

    local OpenButton = Instance.new("TextButton")
    OpenButton.Parent = TopBar
    OpenButton.Size = UDim2.new(1, -50, 1, 0)
    OpenButton.Position = UDim2.new(0, 45, 0, 0)
    OpenButton.BackgroundTransparency = 1
    OpenButton.Text = "FEXAW HUB | OFFICIAL"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 18
    OpenButton.Font = Enum.Font.SourceSansBold
    OpenButton.TextXAlignment = Enum.TextXAlignment.Left

    local IsDragging = false
    local DragStart
    local StartPosTop
    local StartPosMain

    DragButton.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            IsDragging = true
            DragStart = Input.Position
            StartPosTop = TopBar.Position
            StartPosMain = MainFrame.Position
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    IsDragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if IsDragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
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

    local ExitButton = Instance.new("TextButton")
    ExitButton.Parent = MainFrame
    ExitButton.Size = UDim2.new(0, 30, 0, 30)
    ExitButton.Position = UDim2.new(1, -35, 0, 7)
    ExitButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    ExitButton.Text = "X"
    ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", ExitButton)

    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Parent = ScreenGui
    ConfirmFrame.Size = UDim2.new(0, 250, 0, 100)
    ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -50)
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ConfirmFrame.Visible = false
    ConfirmFrame.ZIndex = 50
    Instance.new("UICorner", ConfirmFrame)
    Instance.new("UIStroke", ConfirmFrame).Color = Color3.fromRGB(255, 255, 255)

    local ConfirmLabel = Instance.new("TextLabel")
    ConfirmLabel.Parent = ConfirmFrame
    ConfirmLabel.Size = UDim2.new(1, 0, 0, 50)
    ConfirmLabel.BackgroundTransparency = 1
    ConfirmLabel.Text = "Are you sure you want to close?"
    ConfirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    local YesButton = Instance.new("TextButton")
    YesButton.Parent = ConfirmFrame
    YesButton.Size = UDim2.new(0.4, 0, 0, 30)
    YesButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    YesButton.Text = "Yes"
    YesButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", YesButton)

    local NoButton = Instance.new("TextButton")
    NoButton.Parent = ConfirmFrame
    NoButton.Size = UDim2.new(0.4, 0, 0, 30)
    NoButton.Position = UDim2.new(0.55, 0, 0.6, 0)
    NoButton.Text = "No"
    NoButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", NoButton)

    ExitButton.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
    NoButton.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
    YesButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local SearchBox = Instance.new("TextBox")
    SearchBox.Parent = MainFrame
    SearchBox.Size = UDim2.new(0, 120, 0, 25)
    SearchBox.Position = UDim2.new(1, -165, 0, 10)
    SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.PlaceholderText = "🔍 Search..."
    Instance.new("UICorner", SearchBox)

    local CategoriesData = {}
    local IsFirstTab = true

    function Library:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = SidePanel
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", TabButton)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Parent = ContainerHolder
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 2
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 5)

        if IsFirstTab then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = ThemeColor
            IsFirstTab = false
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContainerHolder:GetChildren()) do v.Visible = false end
            for _, v in pairs(SidePanel:GetChildren()) do 
                if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end 
            end
            TabContent.Visible = true
            TabButton.BackgroundColor3 = ThemeColor
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

            CategoriesData[CategoryName] = {Main = MainCategoryFrame, Items = ItemsFrame, Head = CategoryButton, Childs = {}}

            local CategoryObject = {}
            function CategoryObject:AddToggle(ToggleText, ToggleCallback)
                local IsActive = false
                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Parent = ItemsFrame
                ToggleBtn.Size = UDim2.new(1, 0, 0, 32)
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ToggleBtn.Text = ToggleText
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", ToggleBtn)

                ToggleBtn.MouseButton1Click:Connect(function()
                    IsActive = not IsActive
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = IsActive and ThemeColor or Color3.fromRGB(45, 45, 45)}):Play()
                    ToggleCallback(IsActive)
                end)
                table.insert(CategoriesData[CategoryName].Childs, ToggleBtn)
            end
            
            function CategoryObject:AddButton(ButtonText, ButtonCallback)
                local Btn = Instance.new("TextButton")
                Btn.Parent = ItemsFrame
                Btn.Size = UDim2.new(1, 0, 0, 32)
                Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Btn.Text = ButtonText
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Btn)
                Btn.MouseButton1Click:Connect(ButtonCallback)
                table.insert(CategoriesData[CategoryName].Childs, Btn)
            end

            return CategoryObject
        end
        return TabObject
    end

    local SettingsTab = Library:CreateTab("Settings")
    local Themes = SettingsTab:CreateCategory("UI Themes")
    
    Themes:AddToggle("Rainbow UI", function(State)
        RainbowEnabled = State
    end)
    
    Themes:AddButton("Blue Theme", function()
        RainbowEnabled = false
        ThemeColor = Color3.fromRGB(0, 120, 255)
    end)
    
    Themes:AddButton("Red Theme", function()
        RainbowEnabled = false
        ThemeColor = Color3.fromRGB(255, 0, 0)
    end)

    Themes:AddButton("Green Theme", function()
        RainbowEnabled = false
        ThemeColor = Color3.fromRGB(0, 255, 120)
    end)

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local Query = SearchBox.Text:lower()
        for Name, Data in pairs(CategoriesData) do
            local FoundMatch = false
            for _, Item in pairs(Data.Childs) do
                if Item.Text:lower():find(Query) then Item.Visible = true FoundMatch = true else Item.Visible = false end
            end
            if Query ~= "" and FoundMatch then
                Data.Items.Visible = true
                Data.Head.Text = "^ " .. Name .. " ^"
                Data.Main.Visible = true
            elseif Query == "" then
                Data.Items.Visible = false
                Data.Head.Text = "v " .. Name .. " v"
                Data.Main.Visible = true
            else
                Data.Main.Visible = false
            end
        end
    end)

    return Library
end

return Library

