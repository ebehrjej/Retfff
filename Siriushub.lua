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
        Platinum = Color3.fromRGB(229, 228, 226),
        Bronze = Color3.fromRGB(205, 127, 50),
        Copper = Color3.fromRGB(184, 115, 51),
        Amethyst = Color3.fromRGB(153, 102, 204),
        Turquoise = Color3.fromRGB(64, 224, 208),
        Coral = Color3.fromRGB(255, 127, 80),
        Lilac = Color3.fromRGB(200, 162, 200),
        Slate = Color3.fromRGB(112, 128, 144),
        Olive = Color3.fromRGB(128, 128, 0),
        Silver = Color3.fromRGB(192, 192, 192),
        Rose = Color3.fromRGB(255, 0, 127),
        Violet = Color3.fromRGB(138, 43, 226),
        Azure = Color3.fromRGB(0, 127, 255),
        Cyan = Color3.fromRGB(0, 255, 255),
        Acqua = Color3.fromRGB(0, 255, 127),
        Spring = Color3.fromRGB(150, 255, 0),
        Lemon = Color3.fromRGB(255, 255, 0),
        Amber = Color3.fromRGB(255, 191, 0),
        Persian = Color3.fromRGB(202, 31, 123),
        Brown = Color3.fromRGB(165, 42, 42),
        Maroon = Color3.fromRGB(128, 0, 0),
        Navy = Color3.fromRGB(0, 0, 128),
        Peach = Color3.fromRGB(255, 218, 185)
    }
}

for i = 1, 100 do
    FexawLib.Themes["Theme_Variant_" .. i] = Color3.fromHSV(i / 100, 0.65, 1)
end

function FexawLib:SaveConfig()
    local HttpService = game:GetService("HttpService")
    local success, encoded = pcall(function() return HttpService:JSONEncode(self.SaveData) end)
    if success then 
        writefile("FexawConfig.json", encoded)
    end
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
        local targetColor = self.Themes[themeName]
        for _, stroke in pairs(self.Elements) do
            TweenService:Create(stroke, TweenInfo.new(0.6), {Color = targetColor}):Play()
        end
    end
end

local function handleToggleLogic(button, stateKey, callback)
    local currentState = not FexawLib.States[stateKey]
    FexawLib.States[stateKey] = currentState
    FexawLib.SaveData[stateKey] = currentState
    
    game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
        BackgroundColor3 = currentState and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(40, 40, 40)
    }):Play()
    
    if currentState then
        task.spawn(function()
            while FexawLib.States[stateKey] do
                local now = tick()
                if not FexawLib.Cooldowns[stateKey] or (now - FexawLib.Cooldowns[stateKey]) > 0.45 then
                    FexawLib.Cooldowns[stateKey] = now
                    local success, err = pcall(callback)
                    if not success then warn(err) break end
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
    
    local sg = Instance.new("ScreenGui")
    sg.Parent = p:WaitForChild("PlayerGui")
    sg.Name = "Fexaw_Premium_Final"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 9999

    local main = Instance.new("Frame")
    main.Parent = sg
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 520, 0, 380)
    main.Position = UDim2.new(0.5, -260, 0.5, -190)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = false
    main.ClipsDescendants = true 
    Instance.new("UICorner", main)

    local MainStroke = Instance.new("UIStroke", main)
    MainStroke.Thickness = 3
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    table.insert(self.Elements, MainStroke)

    local DL = Instance.new("TextButton", main)
    DL.Name = "LeftDrag"
    DL.Size = UDim2.new(0, 7, 1, 0)
    DL.BackgroundTransparency = 1
    DL.Text = ""

    local DR = Instance.new("TextButton", main)
    DR.Name = "RightDrag"
    DR.Size = UDim2.new(0, 7, 1, 0)
    DR.Position = UDim2.new(1, -7, 0, 0)
    DR.BackgroundTransparency = 1
    DR.Text = ""

    local ob = Instance.new("Frame", sg)
    ob.Name = "MiniMenu"
    ob.Size = UDim2.new(0, 350, 0, 40)
    ob.Position = UDim2.new(0.5, -175, 0.02, 0)
    ob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ob.BackgroundTransparency = 0.2
    ob.ZIndex = 1000
    Instance.new("UICorner", ob)
    
    local MiniStroke = Instance.new("UIStroke", ob)
    MiniStroke.Thickness = 2
    table.insert(self.Elements, MiniStroke)
    
    local db = Instance.new("TextButton", ob)
    db.Size = UDim2.new(0, 60, 1, 0)
    db.BackgroundTransparency = 1
    db.Text = "÷  |"
    db.TextColor3 = Color3.new(1, 1, 1)
    db.TextSize = 22

    local obn = Instance.new("TextButton", ob)
    obn.Size = UDim2.new(1, -65, 1, 0)
    obn.Position = UDim2.new(0, 65, 0, 0)
    obn.BackgroundTransparency = 1
    obn.Text = "FEXAW | MENU"
    obn.TextColor3 = Color3.new(1, 1, 1)
    obn.TextXAlignment = Enum.TextXAlignment.Left

    local drag, dInp, dStart, sPos, sPosMain
    local function register(e, t)
        e.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = true dStart = i.Position sPos = t.Position sPosMain = main.Position
                i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then drag = false end end)
            end
        end)
        e.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dInp = i end end)
    end
    register(db, ob) register(DL, main) register(DR, main)
    UIS.InputChanged:Connect(function(i)
        if drag and i == dInp then
            local delta = i.Position - dStart
            ob.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
            main.Position = UDim2.new(sPosMain.X.Scale, sPosMain.X.Offset + delta.X, sPosMain.Y.Scale, sPosMain.Y.Offset + delta.Y)
        end
    end)

    local TopBar = Instance.new("Frame", main)
    TopBar.Size = UDim2.new(1, -160, 0, 40)
    TopBar.Position = UDim2.new(0, 160, 0, 0)
    TopBar.BackgroundTransparency = 1

    local CBtn = Instance.new("TextButton", TopBar)
    CBtn.Size = UDim2.new(0, 35, 0, 35)
    CBtn.Position = UDim2.new(1, -40, 0, 2)
    CBtn.Text = "X"
    CBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
    CBtn.BackgroundTransparency = 1
    CBtn.TextSize = 20

    local MBtn = Instance.new("TextButton", TopBar)
    MBtn.Size = UDim2.new(0, 35, 0, 35)
    MBtn.Position = UDim2.new(1, -80, 0, 2)
    MBtn.Text = "-"
    MBtn.TextColor3 = Color3.new(1, 1, 1)
    MBtn.BackgroundTransparency = 1
    MBtn.TextSize = 30

    local SBtn = Instance.new("TextButton", TopBar)
    SBtn.Size = UDim2.new(0, 35, 0, 35)
    SBtn.Position = UDim2.new(1, -120, 0, 2)
    SBtn.Text = "🔍"
    SBtn.TextColor3 = Color3.new(1, 1, 1)
    SBtn.BackgroundTransparency = 1
    SBtn.TextSize = 18

    local SF = Instance.new("Frame", main)
    SF.Size = UDim2.new(0, 0, 0, 32)
    SF.Position = UDim2.new(0, 170, 0, 45)
    SF.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SF.Visible = false
    SF.ClipsDescendants = true
    Instance.new("UICorner", SF)
    
    local SI = Instance.new("TextBox", SF)
    SI.Size = UDim2.new(1, -10, 1, 0)
    SI.Position = UDim2.new(0, 5, 0, 0)
    SI.BackgroundTransparency = 1
    SI.PlaceholderText = "Search..."
    SI.Text = ""
    SI.TextColor3 = Color3.new(1, 1, 1)

    local Conf = Instance.new("Frame", sg)
    Conf.Size = UDim2.new(0, 320, 0, 140)
    Conf.Position = UDim2.new(0.5, -160, 0.5, -70)
    Conf.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Conf.Visible = false
    Conf.ZIndex = 5000
    Instance.new("UICorner", Conf)
    local ConfStroke = Instance.new("UIStroke", Conf)
    ConfStroke.Thickness = 2
    table.insert(self.Elements, ConfStroke)

    local Msg = Instance.new("TextLabel", Conf)
    Msg.Size = UDim2.new(1, 0, 0, 80)
    Msg.BackgroundTransparency = 1
    Msg.Text = "Are you sure you want to close the menu?"
    Msg.TextColor3 = Color3.new(1, 1, 1)
    Msg.TextSize = 16
    Msg.TextWrapped = true

    local Yes = Instance.new("TextButton", Conf)
    Yes.Size = UDim2.new(0, 110, 0, 40)
    Yes.Position = UDim2.new(0.1, 0, 0.6, 0)
    Yes.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
    Yes.Text = "YES"
    Yes.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Yes)

    local No = Instance.new("TextButton", Conf)
    No.Size = UDim2.new(0, 110, 0, 40)
    No.Position = UDim2.new(0.55, 0, 0.6, 0)
    No.BackgroundColor3 = Color3.fromRGB(150, 0, 50)
    No.Text = "NO"
    No.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", No)

    local function tM()
        if not main.Visible then
            main.Visible = true
            main.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 380)}):Play()
        else
            local cl = TS:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
            cl:Play() cl.Completed:Connect(function() if main.Size.X.Offset < 10 then main.Visible = false end end)
        end
    end

    obn.MouseButton1Click:Connect(tM) MBtn.MouseButton1Click:Connect(tM)
    CBtn.MouseButton1Click:Connect(function() Conf.Visible = true end)
    No.MouseButton1Click:Connect(function() Conf.Visible = false end)
    Yes.MouseButton1Click:Connect(function() sg:Destroy() end)
    SBtn.MouseButton1Click:Connect(function()
        SF.Visible = not SF.Visible
        TS:Create(SF, TweenInfo.new(0.3), {Size = SF.Visible and UDim2.new(1, -180, 0, 32) or UDim2.new(0, 0, 0, 32)}):Play()
    end)

    SI:GetPropertyChangedSignal("Text"):Connect(function()
        local query = SI.Text:lower()
        for _, tab in pairs(self.Tabs) do
            for _, obj in pairs(tab.Cont:GetDescendants()) do
                if obj:IsA("TextButton") and obj.Parent:IsA("Frame") and not obj.Parent:IsA("ScrollingFrame") then
                    obj.Parent.Visible = (query == "" or obj.Text:lower():find(query))
                end
            end
        end
    end)

    self.mainFrame = main
    self.sideBar = Instance.new("Frame", main)
    self.sideBar.Size = UDim2.new(0, 150, 1, 0)
    self.sideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", self.sideBar)
    local sideL = Instance.new("UIListLayout", self.sideBar)
    sideL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sideL.VerticalAlignment = Enum.VerticalAlignment.Top
    sideL.Padding = UDim.new(0, 6)

    self.Tabs = {}

    local SettingsTab = self:CreateTab("Settings")
    SettingsTab:AddButton("SAVE ALL CONFIGS", function() self:SaveConfig() end)
    local ThemeCat = SettingsTab:CreateCategory("Themes (150+)")
    ThemeCat:AddButton("Rainbow Dynamic", function() self:SetTheme("Rainbow") end)
    local tL = {} for n in pairs(self.Themes) do table.insert(tL, n) end table.sort(tL)
    for _, n in ipairs(tL) do ThemeCat:AddButton(n, function() self:SetTheme(n) end) end

    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local btn = Instance.new("TextButton", self.sideBar)
    btn.Size = UDim2.new(0.92, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.75, 0.75, 0.75)
    Instance.new("UICorner", btn)

    local cn = Instance.new("ScrollingFrame", self.mainFrame)
    cn.Position = UDim2.new(0, 160, 0, 85)
    cn.Size = UDim2.new(1, -170, 1, -95)
    cn.BackgroundTransparency = 1
    cn.Visible = false
    cn.ScrollBarThickness = 3
    cn.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", cn).Padding = UDim.new(0, 6)

    table.insert(self.Tabs, {Btn = btn, Cont = cn})
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do t.Cont.Visible = false end
        cn.Visible = true
    end)

    local tabObj = {}

    function tabObj:AddToggle(txt, cb)
        local f = Instance.new("Frame", cn)
        f.Size = UDim2.new(1, -12, 0, 32)
        f.BackgroundTransparency = 1
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(1, 0, 1, 0)
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        b.Text = txt
        b.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            handleToggleLogic(b, name .. "_" .. txt, cb)
        end)
    end

    function tabObj:CreateCategory(cN)
        local w = Instance.new("Frame", cn)
        w.Size = UDim2.new(1, -12, 0, 32)
        w.AutomaticSize = Enum.AutomaticSize.Y
        w.BackgroundTransparency = 1
        Instance.new("UIListLayout", w).Padding = UDim.new(0, 5)
        
        local fold = Instance.new("TextButton", w)
        fold.Size = UDim2.new(1, 0, 0, 32)
        fold.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        fold.Text = "v " .. cN .. " v"
        fold.TextColor3 = Color3.new(1, 1, 1)
        fold.LayoutOrder = -1
        Instance.new("UICorner", fold)
        
        local items = Instance.new("Frame", w)
        items.Size = UDim2.new(1, 0, 0, 0)
        items.AutomaticSize = Enum.AutomaticSize.Y
        items.BackgroundTransparency = 1
        items.Visible = false
        Instance.new("UIListLayout", items).Padding = UDim.new(0, 5)
        
        fold.MouseButton1Click:Connect(function()
            items.Visible = not items.Visible
            fold.Text = items.Visible and "^ " .. cN .. " ^" or "v " .. cN .. " v"
        end)

        local catMethods = {}
        function catMethods:AddToggle(t, c)
            local f = Instance.new("Frame", items) f.Size = UDim2.new(1, 0, 0, 30) f.BackgroundTransparency = 1
            local b = Instance.new("TextButton", f) b.Size = UDim2.new(1, 0, 1, 0) b.BackgroundColor3 = Color3.fromRGB(40, 40, 40) b.Text = t b.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() handleToggleLogic(b, name .. "_" .. cN .. "_" .. t, c) end)
        end
        function catMethods:AddButton(t, c)
            local f = Instance.new("Frame", items) f.Size = UDim2.new(1, 0, 0, 30) f.BackgroundTransparency = 1
            local b = Instance.new("TextButton", f) b.Size = UDim2.new(1, 0, 1, 0) b.BackgroundColor3 = Color3.fromRGB(45, 45, 45) b.Text = t b.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() pcall(c) end)
        end
        return catMethods
    end

    function tabObj:AddSlider(t, min, max, def, cb)
        local f = Instance.new("Frame", cn) f.Size = UDim2.new(1, -12, 0, 48) f.BackgroundColor3 = Color3.fromRGB(35, 35, 35) Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f) l.Size = UDim2.new(1, 0, 0, 24) l.Position = UDim2.new(0, 8, 0, 0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.new(1, 1, 1) l.Text = t .. ": " .. def l.TextXAlignment = Enum.TextXAlignment.Left
        local b = Instance.new("Frame", f) b.Size = UDim2.new(0.92, 0, 0, 6) b.Position = UDim2.new(0.04, 0, 0.7, 0) b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        local fl = Instance.new("Frame", b) fl.Size = UDim2.new((def-min)/(max-min), 0, 1, 0) fl.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        local d = false local function upd()
            local p = math.clamp((UIS:GetMouseLocation().X - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max - min) * p) fl.Size = UDim2.new(p, 0, 1, 0) l.Text = t .. ": " .. v pcall(cb, v)
        end
        b.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true end end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
        UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then upd() end end)
    end

    function tabObj:AddDropdown(t, list, cb)
        local f = Instance.new("Frame", cn) f.Size = UDim2.new(1, -12, 0, 34) f.BackgroundColor3 = Color3.fromRGB(35, 35, 35) f.AutomaticSize = Enum.AutomaticSize.Y Instance.new("UICorner", f)
        local btn = Instance.new("TextButton", f) btn.Size = UDim2.new(1, 0, 0, 34) btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) btn.Text = t .. "  [Select]" btn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", btn)
        local d = Instance.new("Frame", f) d.Size = UDim2.new(1, 0, 0, 0) d.Position = UDim2.new(0, 0, 0, 34) d.Visible = false d.AutomaticSize = Enum.AutomaticSize.Y d.BackgroundTransparency = 1 Instance.new("UIListLayout", d)
        btn.MouseButton1Click:Connect(function() d.Visible = not d.Visible end)
        for _, v in pairs(list) do
            local i = Instance.new("TextButton", d) i.Size = UDim2.new(1, 0, 0, 28) i.BackgroundColor3 = Color3.fromRGB(55, 55, 55) i.Text = v i.TextColor3 = Color3.new(0.8, 0.8, 0.8) i.MouseButton1Click:Connect(function() btn.Text = t .. ": " .. v d.Visible = false pcall(cb, v) end)
        end
    end

    function tabObj:AddButton(t, cb)
        local f = Instance.new("Frame", cn) f.Size = UDim2.new(1, -12, 0, 32) f.BackgroundTransparency = 1
        local b = Instance.new("TextButton", f) b.Size = UDim2.new(1, 0, 1, 0) b.BackgroundColor3 = Color3.fromRGB(45, 45, 45) b.Text = t b.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() pcall(cb) end)
    end

    function tabObj:AddTextBox(t, cb)
        local f = Instance.new("Frame", cn) f.Size = UDim2.new(1, -12, 0, 38) f.BackgroundColor3 = Color3.fromRGB(35, 35, 35) Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f) l.Size = UDim2.new(0.4, 0, 1, 0) l.Position = UDim2.new(0, 8, 0, 0) l.BackgroundTransparency = 1 l.Text = t l.TextColor3 = Color3.new(1, 1, 1) l.TextXAlignment = Enum.TextXAlignment.Left
        local box = Instance.new("TextBox", f) box.Size = UDim2.new(0.5, 0, 0.75, 0) box.Position = UDim2.new(0.45, 0, 0.12, 0) box.BackgroundColor3 = Color3.fromRGB(25, 25, 25) box.Text = "" box.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", box)
        box.FocusLost:Connect(function(e) if e then pcall(cb, box.Text) end end)
        
