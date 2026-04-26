FexawLib = {}

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local RS = game:GetService("RunService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "FexawV3_Official"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = false
    MainFrame.ClipsDescendants = true 
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Parent = MainFrame
    MainStroke.Thickness = 3
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local DragHandleLeft = Instance.new("Frame", MainFrame)
    DragHandleLeft.Name = "DragLeft"
    DragHandleLeft.Size = UDim2.new(0, 7, 1, 0)
    DragHandleLeft.BackgroundColor3 = Color3.new(1, 1, 1)
    DragHandleLeft.BackgroundTransparency = 0.9
    Instance.new("UICorner", DragHandleLeft)

    local DragHandleRight = Instance.new("Frame", MainFrame)
    DragHandleRight.Name = "DragRight"
    DragHandleRight.Size = UDim2.new(0, 7, 1, 0)
    DragHandleRight.Position = UDim2.new(1, -7, 0, 0)
    DragHandleRight.BackgroundColor3 = Color3.new(1, 1, 1)
    DragHandleRight.BackgroundTransparency = 0.9
    Instance.new("UICorner", DragHandleRight)

    local SideBar = Instance.new("Frame", MainFrame)
    SideBar.Name = "SideBar"
    SideBar.Size = UDim2.new(0, 150, 1, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", SideBar)
    
    local SideLayout = Instance.new("UIListLayout", SideBar)
    SideLayout.Padding = UDim.new(0, 5)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local SideStroke = Instance.new("UIStroke", SideBar)
    SideStroke.Thickness = 2
    SideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local ToggleFrame = Instance.new("Frame", ScreenGui)
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Size = UDim2.new(0, 350, 0, 40)
    ToggleFrame.Position = UDim2.new(0.5, -175, 0.2, 0)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ToggleFrame.BackgroundTransparency = 0.2
    Instance.new("UICorner", ToggleFrame)
    
    local ToggleStroke = Instance.new("UIStroke", ToggleFrame)
    ToggleStroke.Thickness = 2

    local DragButton = Instance.new("TextButton", ToggleFrame)
    DragButton.Size = UDim2.new(0, 60, 1, 0)
    DragButton.BackgroundTransparency = 1
    DragButton.Text = "÷  |"
    DragButton.TextColor3 = Color3.new(1, 1, 1)
    DragButton.TextSize = 22
    
    local OpenButton = Instance.new("TextButton", ToggleFrame)
    OpenButton.Size = UDim2.new(1, -65, 1, 0)
    OpenButton.Position = UDim2.new(0, 65, 0, 0)
    OpenButton.BackgroundTransparency = 1
    OpenButton.Text = "FEXAW | MENU"
    OpenButton.TextColor3 = Color3.new(1, 1, 1)
    OpenButton.TextXAlignment = Enum.TextXAlignment.Left

    local themes = {
        Neon = Color3.fromRGB(0, 255, 255), Fire = Color3.fromRGB(255, 50, 0), Water = Color3.fromRGB(0, 100, 255),
        Toxic = Color3.fromRGB(170, 255, 0), Matrix = Color3.fromRGB(0, 255, 70), Lava = Color3.fromRGB(255, 0, 0),
        Candy = Color3.fromRGB(255, 0, 200), Gold = Color3.fromRGB(255, 200, 0), Space = Color3.fromRGB(100, 0, 255),
        Midnight = Color3.fromRGB(25, 25, 50), Sky = Color3.fromRGB(0, 170, 255), Forest = Color3.fromRGB(30, 150, 30)
    }
    for i = 1, 138 do themes["Theme_"..i] = Color3.fromHSV(i/138, 0.8, 1) end

    local rainbowConnection = nil
    function self:SetTheme(themeName)
        if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
        if themeName == "Rainbow" then
            rainbowConnection = RS.RenderStepped:Connect(function()
                local color = Color3.fromHSV(tick()%5/5, 1, 1)
                MainStroke.Color = color
                SideStroke.Color = color
                ToggleStroke.Color = color
            end)
        elseif themes[themeName] then
            local targetColor = themes[themeName]
            TS:Create(MainStroke, TweenInfo.new(0.5), {Color = targetColor}):Play()
            TS:Create(SideStroke, TweenInfo.new(0.5), {Color = targetColor}):Play()
            TS:Create(ToggleStroke, TweenInfo.new(0.5), {Color = targetColor}):Play()
        end
    end

    local dragging, dragStart, startPos, mainStartPos
    local function initDrag(guiElement)
        guiElement.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = ToggleFrame.Position
                mainStartPos = MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
    end
    initDrag(DragHandleLeft) initDrag(DragHandleRight) initDrag(DragButton)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            ToggleFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            MainFrame.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + delta.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + delta.Y)
        end
    end)

    OpenButton.MouseButton1Click:Connect(function()
        if not MainFrame.Visible then
            MainFrame.Visible = true
            TS:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 380)}):Play()
        else
            local closeTween = TS:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            closeTween:Play()
            closeTween.Completed:Connect(function() if MainFrame.Size.X.Offset < 10 then MainFrame.Visible = false end end)
        end
    end)

    self.mainFrame = MainFrame
    self.sideBar = SideBar
    self.tabsList = {}
    
    local settings = self:CreateTab("Settings")
    local themesCat = settings:CreateCategory("Official Themes")
    themesCat:AddButton("Rainbow", function() self:SetTheme("Rainbow") end)
    for name, _ in pairs(themes) do
        themesCat:AddButton(name, function() self:SetTheme(name) end)
    end
    
    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local TabButton = Instance.new("TextButton", self.sideBar)
    TabButton.Size = UDim2.new(0.9, 0, 0, 32)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabButton.Text, TabButton.TextColor3 = name, Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", TabButton)

    local ContentFrame = Instance.new("ScrollingFrame", self.mainFrame)
    ContentFrame.Position, ContentFrame.Size = UDim2.new(0, 160, 0, 10), UDim2.new(1, -170, 1, -20)
    ContentFrame.BackgroundTransparency, ContentFrame.Visible = 1, false
    ContentFrame.ScrollBarThickness, ContentFrame.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", ContentFrame).Padding = UDim.new(0, 5)

    table.insert(self.tabsList, {Btn = TabButton, Cont = ContentFrame})
    
    TabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(self.tabsList) do 
            t.Cont.Visible = false 
            game:GetService("TweenService"):Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.new(0.7, 0.7, 0.7)}):Play()
        end
        ContentFrame.Visible = true
        game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50), TextColor3 = Color3.new(1, 1, 1)}):Play()
    end)

    local tabScope = {}
    function tabScope:AddTextBox(txt, cb)
        local f = Instance.new("Frame", ContentFrame)
        f.Size, f.BackgroundColor3 = UDim2.new(1, -10, 0, 35), Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f)
        l.Size, l.Position = UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 5, 0, 0)
        l.BackgroundTransparency, l.Text, l.TextColor3 = 1, txt, Color3.new(1, 1, 1)
        l.TextXAlignment = Enum.TextXAlignment.Left
        local box = Instance.new("TextBox", f)
        box.Size, box.Position = UDim2.new(0.5, 0, 0.8, 0), UDim2.new(0.45, 0, 0.1, 0)
        box.BackgroundColor3, box.TextColor3, box.Text = Color3.fromRGB(25, 25, 25), Color3.new(1, 1, 1), ""
        box.PlaceholderText = "..."
        Instance.new("UICorner", box)
        box.FocusLost:Connect(function(e) if e then pcall(cb, box.Text) end end)
    end

    function tabScope:CreateCategory(n)
        local cf = Instance.new("Frame", ContentFrame)
        cf.Size, cf.AutomaticSize, cf.BackgroundTransparency = UDim2.new(1, -10, 0, 32), Enum.AutomaticSize.Y, 1
        Instance.new("UIListLayout", cf).Padding = UDim.new(0, 5)
        
        local fb = Instance.new("TextButton", cf)
        fb.Size, fb.BackgroundColor3, fb.LayoutOrder = UDim2.new(1, 0, 0, 30), Color3.fromRGB(35, 35, 35), -1
        fb.Text, fb.TextColor3 = "v " .. n .. " v", Color3.new(1, 1, 1)
        Instance.new("UICorner", fb)
        
        local f_cat = Instance.new("Frame", cf)
        f_cat.Size, f_cat.AutomaticSize, f_cat.BackgroundTransparency, f_cat.LayoutOrder = UDim2.new(1, 0, 0, 0), Enum.AutomaticSize.Y, 1, 1
        f_cat.Visible = false
        Instance.new("UIListLayout", f_cat).Padding = UDim.new(0, 5)
        
        fb.MouseButton1Click:Connect(function()
            f_cat.Visible = not f_cat.Visible
            fb.Text = (f_cat.Visible and "^ " or "v ") .. n .. (f_cat.Visible and " ^" or " v")
        end)
        
        local catScope = {}
        function catScope:AddToggle(txt, cb)
            local b = Instance.new("TextButton", f_cat)
            b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(40, 40, 40), txt, Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            local a = false
            b.MouseButton1Click:Connect(function()
                a = not a
                game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = a and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
                task.spawn(function() while a do pcall(cb) task.wait(0.3) end end)
            end)
        end
        function catScope:AddButton(txt, cb)
            local b = Instance.new("TextButton", f_cat)
            b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(45, 45, 45), txt, Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() pcall(cb) end)
        end
        return catScope
    end
    return tabScope
end

return FexawLib
