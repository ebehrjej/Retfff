FexawLib = {
    SaveData = {},
    States = {},
    Cooldowns = {},
    Elements = {},
    Tabs = {},
    Themes = {
        Neon = Color3.fromRGB(0, 255, 255),
        Fire = Color3.fromRGB(255, 50, 0),
        Water = Color3.fromRGB(0, 100, 255),
        Toxic = Color3.fromRGB(170, 255, 0),
        Matrix = Color3.fromRGB(0, 255, 70),
        Lava = Color3.fromRGB(255, 0, 0),
        Candy = Color3.fromRGB(255, 0, 200),
        Gold = Color3.fromRGB(255, 200, 0),
        Space = Color3.fromRGB(100, 0, 255),
        Midnight = Color3.fromRGB(25, 25, 50),
        Sky = Color3.fromRGB(0, 170, 255),
        Forest = Color3.fromRGB(30, 150, 30),
        Sun = Color3.fromRGB(255, 255, 0),
        Blood = Color3.fromRGB(150, 0, 0),
        Mint = Color3.fromRGB(150, 255, 200),
        Desert = Color3.fromRGB(230, 190, 130),
        Ice = Color3.fromRGB(200, 240, 255),
        Void = Color3.fromRGB(10, 10, 10),
        Wine = Color3.fromRGB(120, 0, 40),
        Sakura = Color3.fromRGB(255, 180, 200),
        Lime = Color3.fromRGB(100, 255, 0),
        Orange = Color3.fromRGB(255, 120, 0),
        Purple = Color3.fromRGB(180, 0, 255),
        Ocean = Color3.fromRGB(0, 80, 150),
        Emerald = Color3.fromRGB(0, 200, 100),
        Ruby = Color3.fromRGB(220, 20, 60),
        Sapphire = Color3.fromRGB(15, 82, 186),
        Bronze = Color3.fromRGB(205, 127, 50),
        Silver = Color3.fromRGB(192, 192, 192),
        Amethyst = Color3.fromRGB(153, 102, 204),
        Turquoise = Color3.fromRGB(64, 224, 208),
        Coral = Color3.fromRGB(255, 127, 80),
        Lilac = Color3.fromRGB(200, 162, 200),
        Olive = Color3.fromRGB(128, 128, 0),
        Azure = Color3.fromRGB(0, 127, 255),
        Rose = Color3.fromRGB(255, 0, 127),
        Cyan = Color3.fromRGB(0, 255, 255),
        Amber = Color3.fromRGB(255, 191, 0),
        Peach = Color3.fromRGB(255, 218, 185),
        Khaki = Color3.fromRGB(240, 230, 140),
        Lavender = Color3.fromRGB(230, 230, 250),
        Plum = Color3.fromRGB(221, 160, 221),
        Ivory = Color3.fromRGB(255, 255, 240),
        Beige = Color3.fromRGB(245, 245, 220),
        Snow = Color3.fromRGB(255, 250, 250),
        Slate = Color3.fromRGB(112, 128, 144),
        Navy = Color3.fromRGB(0, 0, 128),
        Teal = Color3.fromRGB(0, 128, 128),
        Maroon = Color3.fromRGB(128, 0, 0)
    }
}

for i = 1, 101 do
    FexawLib.Themes["Hue_Variant_" .. i] = Color3.fromHSV(i / 101, 0.65, 1)
end

function FexawLib:SaveConfig()
    local HttpService = game:GetService("HttpService")
    local success, json = pcall(function() return HttpService:JSONEncode(self.SaveData) end)
    if success then writefile("FexawConfig.json", json) end
end

function FexawLib:SetTheme(themeName)
    local TweenService = game:GetService("TweenService")
    if self.RainbowLoop then self.RainbowLoop:Disconnect() self.RainbowLoop = nil end
    if themeName == "Rainbow" then
        self.RainbowLoop = game:GetService("RunService").RenderStepped:Connect(function()
            local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            for _, stroke in pairs(self.Elements) do stroke.Color = color end
        end)
    elseif self.Themes[themeName] then
        local color = self.Themes[themeName]
        for _, stroke in pairs(self.Elements) do
            TweenService:Create(stroke, TweenInfo.new(0.6), {Color = color}):Play()
        end
    end
end

local function handleToggleLogic(button, stateKey, callback)
    local active = not FexawLib.States[stateKey]
    FexawLib.States[stateKey] = active
    FexawLib.SaveData[stateKey] = active
    
    game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
        BackgroundColor3 = active and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(40, 40, 40)
    }):Play()
    
    if active then
        task.spawn(function()
            while FexawLib.States[stateKey] do
                if not FexawLib.Cooldowns[stateKey] or (tick() - FexawLib.Cooldowns[stateKey]) > 0.45 then
                    FexawLib.Cooldowns[stateKey] = tick()
                    pcall(callback)
                end
                task.wait(0.1)
            end
        end)
    end
end

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game:GetService("Players").LocalPlayer
    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "Fexaw_Mobile_Ultimate"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 9999

    local BackOverlay = Instance.new("TextButton")
    BackOverlay.Parent = sg
    BackOverlay.Size = UDim2.new(1, 0, 1, 0)
    BackOverlay.BackgroundTransparency = 1
    BackOverlay.Text = ""
    BackOverlay.Visible = false
    BackOverlay.ZIndex = 1

    local main = Instance.new("Frame")
    main.Parent = sg
    main.Name = "CenterBar"
    main.Size = UDim2.new(0, 125, 1, 0)
    main.Position = UDim2.new(0.5, -62, 0, 0)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = false
    main.ClipsDescendants = true
    main.ZIndex = 5
    
    local ms = Instance.new("UIStroke", main)
    ms.Thickness = 4
    ms.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    table.insert(self.Elements, ms)

    local TopHeader = Instance.new("Frame", main)
    TopHeader.Size = UDim2.new(1, 0, 0, 120)
    TopHeader.BackgroundTransparency = 1

    local CloseBtn = Instance.new("TextButton", TopHeader)
    CloseBtn.Size = UDim2.new(1, 0, 0, 35)
    CloseBtn.Position = UDim2.new(0, 0, 0, 5)
    CloseBtn.Text = "[ CLOSE X ]"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Font = Enum.Font.SourceSansBold

    local SearchBtn = Instance.new("TextButton", TopHeader)
    SearchBtn.Size = UDim2.new(1, 0, 0, 35)
    SearchBtn.Position = UDim2.new(0, 0, 0, 40)
    SearchBtn.Text = "SEARCH 🔍"
    SearchBtn.TextColor3 = Color3.new(1, 1, 1)
    SearchBtn.BackgroundTransparency = 1
    SearchBtn.Font = Enum.Font.SourceSansBold

    local SearchFrame = Instance.new("Frame", main)
    SearchFrame.Size = UDim2.new(1, -10, 0, 30)
    SearchFrame.Position = UDim2.new(0, 5, 0, 80)
    SearchFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SearchFrame.Visible = false
    Instance.new("UICorner", SearchFrame)
    
    local SearchInput = Instance.new("TextBox", SearchFrame)
    SearchInput.Size = UDim2.new(1, -10, 1, 0)
    SearchInput.Position = UDim2.new(0, 5, 0, 0)
    SearchInput.BackgroundTransparency = 1
    SearchInput.PlaceholderText = "..."
    SearchInput.TextColor3 = Color3.new(1, 1, 1)

    local ob = Instance.new("Frame", sg)
    ob.Name = "ToggleIcon"
    ob.Size = UDim2.new(0, 320, 0, 40)
    ob.Position = UDim2.new(0.5, -160, 0.015, 0)
    ob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ob.BackgroundTransparency = 0.2
    ob.ZIndex = 10000
    Instance.new("UICorner", ob)
    
    local os = Instance.new("UIStroke", ob)
    os.Thickness = 2
    table.insert(self.Elements, os)
    
    local db = Instance.new("TextButton", ob)
    db.Size = UDim2.new(0, 55, 1, 0)
    db.BackgroundTransparency = 1
    db.Text = "÷"
    db.TextColor3 = Color3.new(1, 1, 1)
    db.TextSize = 25

    local obn = Instance.new("TextButton", ob)
    obn.Size = UDim2.new(1, -60, 1, 0)
    obn.Position = UDim2.new(0, 60, 0, 0)
    obn.BackgroundTransparency = 1
    obn.Text = "FEXAW MOBILE HUB"
    obn.TextColor3 = Color3.new(1, 1, 1)
    obn.TextXAlignment = Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, mStartPos
    db.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = i.Position startPos = ob.Position mStartPos = main.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local function toggleMenu(state)
        if state then
            main.Visible = true
            BackOverlay.Visible = true
            main.Position = UDim2.new(0.5, -62, 1, 0)
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -62, 0, 0)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -62, 1, 0)})
            tw:Play()
            tw.Completed:Connect(function() main.Visible = false BackOverlay.Visible = false end)
        end
    end

    obn.MouseButton1Click:Connect(function() toggleMenu(true) end)
    BackOverlay.MouseButton1Click:Connect(function() toggleMenu(false) end)
    CloseBtn.MouseButton1Click:Connect(function() toggleMenu(false) end)
    SearchBtn.MouseButton1Click:Connect(function() SearchFrame.Visible = not SearchFrame.Visible end)

    SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
        local t = SearchInput.Text:lower()
        for _, tab in pairs(self.Tabs) do
            for _, item in pairs(tab.Cont:GetDescendants()) do
                if item:IsA("TextButton") and item.Parent:IsA("Frame") then
                    item.Parent.Visible = (t == "" or item.Text:lower():find(t))
                end
            end
        end
    end)

    self.mainFrame = main
    self.tabButtonsFrame = Instance.new("Frame", main)
    self.tabButtonsFrame.Size = UDim2.new(1, 0, 0, 45)
    self.tabButtonsFrame.Position = UDim2.new(0, 0, 0, 120)
    self.tabButtonsFrame.BackgroundTransparency = 1
    local tbl = Instance.new("UIListLayout", self.tabButtonsFrame)
    tbl.FillDirection = Enum.FillDirection.Horizontal
    tbl.HorizontalAlignment = Enum.HorizontalAlignment.Center

    self.Tabs = {}

    -- АВТОМАТИЧЕСКАЯ ВКЛАДКА НАСТРОЕК
    local SettingsTab = self:CreateTab("S") 
    SettingsTab:AddButton("SAVE CONFIG", function() self:SaveConfig() end)
    local ThemeCat = SettingsTab:CreateCategory("THEMES")
    ThemeCat:AddButton("Rainbow", function() self:SetTheme("Rainbow") end)
    
    local sortedThemes = {}
    for name in pairs(self.Themes) do table.insert(sortedThemes, name) end
    table.sort(sortedThemes)
    for _, themeName in ipairs(sortedThemes) do
        ThemeCat:AddButton(themeName, function() self:SetTheme(themeName) end)
    end

    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local TabBtn = Instance.new("TextButton", self.tabButtonsFrame)
    TabBtn.Size = UDim2.new(0, 35, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.Text = name:sub(1,1):upper()
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", TabBtn)
    local btnStroke = Instance.new("UIStroke", TabBtn)
    btnStroke.Thickness = 2
    table.insert(self.Elements, btnStroke)

    local Content = Instance.new("ScrollingFrame", self.mainFrame)
    Content.Position = UDim2.new(0, 5, 0, 175)
    Content.Size = UDim2.new(1, -10, 1, -185)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.ScrollBarThickness = 0
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", Content).Padding = UDim.new(0, 6)

    table.insert(self.Tabs, {Btn = TabBtn, Cont = Content})
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do 
            t.Cont.Visible = false 
            t.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
        Content.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    local tabObj = {}

    function tabObj:AddToggle(text, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1, 0, 0, 55)
        frame.BackgroundTransparency = 1
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextWrapped = true
        Instance.new("UICorner", btn)
        local s = Instance.new("UIStroke", btn)
        s.Thickness = 2 table.insert(self.Elements, s)
        
        btn.MouseButton1Click:Connect(function()
            handleToggleLogic(btn, name .. "_" .. text, callback)
        end)
    end

    function tabObj:AddButton(text, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1, 0, 0, 55)
        frame.BackgroundTransparency = 1
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextWrapped = true
        Instance.new("UICorner", btn)
        local s = Instance.new("UIStroke", btn)
        s.Thickness = 2 table.insert(self.Elements, s)
        btn.MouseButton1Click:Connect(function() pcall(callback) end)
    end

    function tabObj:CreateCategory(catName)
        local wrapper = Instance.new("Frame", Content)
        wrapper.Size = UDim2.new(1, 0, 0, 35)
        wrapper.AutomaticSize = Enum.AutomaticSize.Y
        wrapper.BackgroundTransparency = 1
        Instance.new("UIListLayout", wrapper).Padding = UDim.new(0, 5)

        local fold = Instance.new("TextButton", wrapper)
        fold.Size = UDim2.new(1, 0, 0, 35)
        fold.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        fold.Text = catName
        fold.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", fold)
        local fs = Instance.new("UIStroke", fold)
        fs.Thickness = 2 table.insert(self.Elements, fs)

        local container = Instance.new("Frame", wrapper)
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundTransparency = 1
        container.Visible = false
        Instance.new("UIListLayout", container).Padding = UDim.new(0, 5)

        fold.MouseButton1Click:Connect(function() container.Visible = not container.Visible end)

        local catObj = {}
        function catObj:AddButton(t, c)
            local fr = Instance.new("Frame", container)
            fr.Size = UDim2.new(1, 0, 0, 45)
            fr.BackgroundTransparency = 1
            local b = Instance.new("TextButton", fr)
            b.Size = UDim2.new(1, 0, 1, 0)
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            b.Text = t
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextWrapped = true
            Instance.new("UICorner", b)
            local s = Instance.new("UIStroke", b)
            s.Thickness = 1 table.insert(self.Elements, s)
            b.MouseButton1Click:Connect(c)
        end
        function catObj:AddToggle(t, c)
            local fr = Instance.new("Frame", container)
            fr.Size = UDim2.new(1, 0, 0, 45)
            fr.BackgroundTransparency = 1
            local b = Instance.new("TextButton", fr)
            b.Size = UDim2.new(1, 0, 1, 0)
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            b.Text = t
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextWrapped = true
            Instance.new("UICorner", b)
            local s = Instance.new("UIStroke", b)
            s.Thickness = 1 table.insert(self.Elements, s)
            b.MouseButton1Click:Connect(function() handleToggleLogic(b, name .. "_" .. catName .. "_" .. t, c) end)
        end
        return catObj
    end

    function tabObj:AddSlider(text, min, max, def, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1, 0, 0, 65)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", frame)
        local s = Instance.new("UIStroke", frame)
        s.Thickness = 2 table.insert(self.Elements, s)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 0, 30)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. def
        label.TextColor3 = Color3.new(1, 1, 1)

        local bar = Instance.new("Frame", frame)
        bar.Size = UDim2.new(0.9, 0, 0, 6)
        bar.Position = UDim2.new(0.05, 0, 0.7, 0)
        bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        
        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        
        local active = false
        local function update()
            local p = math.clamp((UIS:GetMouseLocation().X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max - min) * p)
            fill.Size, label.Text = UDim2.new(p, 0, 1, 0), text .. ": " .. v
            pcall(callback, v)
        end
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then active = true end end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then active = false end end)
        UIS.InputChanged:Connect(function(i) if active then update() end end)
    end

    function tabObj:AddDropdown(text, list, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1, 0, 0, 45)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.AutomaticSize = Enum.AutomaticSize.Y
        Instance.new("UICorner", frame)
        local s = Instance.new("UIStroke", frame)
        s.Thickness = 2 table.insert(self.Elements, s)

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 0, 45)
        btn.BackgroundTransparency = 1
        btn.Text = text .. " ▼"
        btn.TextColor3 = Color3.new(1, 1, 1)

        local drop = Instance.new("Frame", frame)
        drop.Size = UDim2.new(1, 0, 0, 0)
        drop.Position = UDim2.new(0, 0, 0, 45)
        drop.Visible = false
        drop.AutomaticSize = Enum.AutomaticSize.Y
        drop.BackgroundTransparency = 1
        Instance.new("UIListLayout", drop)

        btn.MouseButton1Click:Connect(function() drop.Visible = not drop.Visible end)
        for _, val in pairs(list) do
            local item = Instance.new("TextButton", drop)
            item.Size = UDim2.new(1, 0, 0, 35)
            item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            item.Text = tostring(val)
            item.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            item.MouseButton1Click:Connect(function() btn.Text, drop.Visible = text .. ": " .. val, false pcall(callback, val) end)
        end
    end

    return tabObj
end

return FexawLib
