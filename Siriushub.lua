local FexawLib = {
    SaveData = {},
    States = {},
    Cooldowns = {},
    Elements = {Accents = {}, Strokes = {}, Texts = {}},
    Tabs = {},
    Themes = {
        Neon = Color3.fromRGB(160, 100, 255),
        Thunder = Color3.fromRGB(0, 200, 255),
        Fire = Color3.fromRGB(255, 60, 60),
        Emerald = Color3.fromRGB(0, 255, 120),
        Gold = Color3.fromRGB(255, 200, 0),
        Ocean = Color3.fromRGB(0, 120, 255),
        Lava = Color3.fromRGB(255, 100, 0),
        Mint = Color3.fromRGB(150, 255, 200),
        Sakura = Color3.fromRGB(255, 150, 200),
        Void = Color3.fromRGB(20, 20, 25),
        White = Color3.fromRGB(255, 255, 255),
        Amethyst = Color3.fromRGB(153, 102, 204),
        Ruby = Color3.fromRGB(220, 20, 60),
        Candy = Color3.fromRGB(255, 0, 150),
        Sky = Color3.fromRGB(135, 206, 235),
        Bronze = Color3.fromRGB(205, 127, 50),
        Silver = Color3.fromRGB(192, 192, 192),
        Platinum = Color3.fromRGB(229, 228, 226),
        DeepSea = Color3.fromRGB(0, 50, 100),
        Forest = Color3.fromRGB(34, 139, 34),
        Plum = Color3.fromRGB(221, 160, 221),
        Azure = Color3.fromRGB(0, 127, 255),
        Coral = Color3.fromRGB(255, 127, 80)
    }
}

for i = 1, 130 do
    FexawLib.Themes["Official_Palette_" .. i] = Color3.fromHSV(i / 130, 0.7, 1)
end

function FexawLib:SaveConfig()
    local success, json = pcall(function() return game:GetService("HttpService"):JSONEncode(self.SaveData) end)
    if success then writefile("Fexaw_Official_V12.json", json) end
end

function FexawLib:SetTheme(n)
    local TS = game:GetService("TweenService")
    local c = self.Themes[n] or self.Themes.Neon
    if self.RainbowLoop then self.RainbowLoop:Disconnect() self.RainbowLoop = nil end
    if n == "Rainbow" then
        self.RainbowLoop = game:GetService("RunService").RenderStepped:Connect(function()
            local clr = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            for _, s in pairs(self.Elements.Accents) do 
                if s:IsA("UIStroke") then s.Color = clr else s.BackgroundColor3 = clr end 
            end
        end)
    else
        for _, s in pairs(self.Elements.Accents) do
            if s:IsA("UIStroke") then TS:Create(s, TweenInfo.new(0.5), {Color = c}):Play() 
            elseif s:IsA("TextLabel") or s:IsA("TextButton") then TS:Create(s, TweenInfo.new(0.5), {TextColor3 = c}):Play()
            else TS:Create(s, TweenInfo.new(0.5), {BackgroundColor3 = c}):Play() end
        end
    end
end

local function handleToggle(button, circle, stateKey, callback)
    local state = not FexawLib.States[stateKey]
    FexawLib.States[stateKey] = state
    FexawLib.SaveData[stateKey] = state
    local TS = game:GetService("TweenService")
    TS:Create(circle, TweenInfo.new(0.3), {Position = state and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 4, 0.5, -7), BackgroundColor3 = state and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)}):Play()
    TS:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(100, 50, 255) or Color3.fromRGB(50, 50, 60)}):Play()
    if state then
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
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "Fexaw_Thunder_V12"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 100

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 650, 0, 450)
    main.Position = UDim2.new(0.5, -325, 0.5, -225)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
    local ms = Instance.new("UIStroke", main)
    ms.Thickness = 2
    table.insert(self.Elements.Accents, ms)

    local side = Instance.new("Frame", main)
    side.Size = UDim2.new(0, 200, 1, 0)
    side.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
    Instance.new("UICorner", side).CornerRadius = UDim.new(0, 15)

    local sideLogo = Instance.new("TextLabel", side)
    sideLogo.Size = UDim2.new(1, 0, 0, 70)
    sideLogo.Position = UDim2.new(0, 20, 0, 0)
    sideLogo.Text = "FEXAW HUB"
    sideLogo.TextColor3 = Color3.new(1,1,1)
    sideLogo.TextXAlignment = Enum.TextXAlignment.Left
    sideLogo.Font = Enum.Font.SourceSansBold
    sideLogo.TextSize = 24
    sideLogo.BackgroundTransparency = 1
    table.insert(self.Elements.Accents, sideLogo)

    local scroll = Instance.new("ScrollingFrame", side)
    scroll.Size = UDim2.new(1, 0, 1, -90)
    scroll.Position = UDim2.new(0, 0, 0, 80)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 0
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1, -200, 0, 60)
    top.Position = UDim2.new(0, 200, 0, 0)
    top.BackgroundTransparency = 1
    
    local info = Instance.new("TextLabel", top)
    info.Size = UDim2.new(1, -120, 1, 0)
    info.Position = UDim2.new(0, 20, 0, 0)
    info.Text = "Premium Edition | Grow a Garden"
    info.TextColor3 = Color3.fromRGB(150, 150, 170)
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.SourceSans

    local ctrl = Instance.new("Frame", top)
    ctrl.Size = UDim2.new(0, 120, 1, 0)
    ctrl.Position = UDim2.new(1, -130, 0, 0)
    ctrl.BackgroundTransparency = 1
    
    local Close = Instance.new("TextButton", ctrl)
    Close.Size = UDim2.new(0, 35, 0, 35)
    Close.Position = UDim2.new(1, -40, 0, 12)
    Close.Text = "X"
    Close.TextColor3 = Color3.new(1, 0.2, 0.2)
    Close.BackgroundTransparency = 1
    Close.TextSize = 20

    local Mini = Instance.new("TextButton", ctrl)
    Mini.Size = UDim2.new(0, 35, 0, 35)
    Mini.Position = UDim2.new(1, -85, 0, 12)
    Mini.Text = "-"
    Mini.TextColor3 = Color3.new(1, 1, 1)
    Mini.BackgroundTransparency = 1
    Mini.TextSize = 25

    local toggleBtn = Instance.new("Frame", sg)
    toggleBtn.Size = UDim2.new(0, 60, 0, 60)
    toggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Instance.new("UICorner", toggleBtn, UDim.new(1, 0))
    local ts_t = Instance.new("UIStroke", toggleBtn)
    ts_t.Thickness = 2
    table.insert(self.Elements.Accents, ts_t)
    
    local tb = Instance.new("TextButton", toggleBtn)
    tb.Size = UDim2.new(1, 0, 1, 0)
    tb.Text = "F"
    tb.TextColor3 = Color3.new(1, 1, 1)
    tb.BackgroundTransparency = 1
    tb.TextSize = 20

    local drag, dS, sP
    main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dS, sP = true, i.Position, main.Position end end)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dS
        main.Position = UDim2.new(sP.X.Scale, sP.X.Offset + delta.X, sP.Y.Scale, sP.Y.Offset + delta.Y)
    end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

    local dragT, dST, sPT
    tb.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragT, dST, sPT = true, i.Position, toggleBtn.Position end end)
    UIS.InputChanged:Connect(function(i) if dragT and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dST
        toggleBtn.Position = UDim2.new(sPT.X.Scale, sPT.X.Offset + delta.X, sPT.Y.Scale, sPT.Y.Offset + delta.Y)
    end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragT = false end end)

    tb.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    Mini.MouseButton1Click:Connect(function() main.Visible = false end)
    Close.MouseButton1Click:Connect(function() sg:Destroy() end)

    self.mainFrame = main
    self.sideScroll = scroll
    self.Tabs = {}
    self.sg = sg
    
    local SetTab = self:CreateTab("Settings")
    SetTab:AddButton("Save Configuration", "Store all toggles to JSON", function() self:SaveConfig() end)
    local ThCat = SetTab:CreateCategory("Theme Engine")
    ThCat:AddButton("Rainbow Dynamic", "Cycle through colors", function() self:SetTheme("Rainbow") end)
    local sn = {} for n in pairs(self.Themes) do table.insert(sn, n) end table.sort(sn)
    for _, n in ipairs(sn) do ThCat:AddButton(n, "Switch to " .. n, function() self:SetTheme(n) end) end

    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateCategory(name)
    local l = Instance.new("TextLabel", self.sideScroll)
    l.Size = UDim2.new(1, 0, 0, 30)
    l.Text = "  • " .. name:upper()
    l.TextColor3 = Color3.fromRGB(110, 110, 130)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 14
    return self
end

function FexawLib:CreateTab(name)
    local btn = Instance.new("TextButton", self.sideScroll)
    btn.Size = UDim2.new(0.94, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 35)
    btn.Text = "     " .. name
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    local bs = Instance.new("UIStroke", btn)
    bs.Thickness = 1
    bs.Transparency = 0.8
    table.insert(FexawLib.Elements.Accents, bs)

    local content = Instance.new("ScrollingFrame", self.mainFrame)
    content.Position = UDim2.new(0, 215, 0, 70)
    content.Size = UDim2.new(1, -230, 1, -85)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.ScrollBarThickness = 0
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", content).Padding = UDim.new(0, 12)

    table.insert(self.Tabs, {Btn = btn, Cont = content})
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do t.Cont.Visible, t.Btn.TextColor3 = false, Color3.fromRGB(180,180,190) end
        content.Visible, btn.TextColor3 = true, Color3.new(1,1,1)
    end)

    local tabObj = {}

    function tabObj:AddToggle(title, desc, callback)
        local f = Instance.new("Frame", content)
        f.Size = UDim2.new(1, 0, 0, 65)
        f.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Instance.new("UICorner", f)
        local s = Instance.new("UIStroke", f)
        s.Thickness = 1
        s.Transparency = 0.6
        table.insert(FexawLib.Elements.Accents, s)
        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1, -80, 0, 35)
        t.Position = UDim2.new(0, 15, 0, 5)
        t.Text = title
        t.TextColor3 = Color3.new(1,1,1)
        t.Font = Enum.Font.SourceSansBold
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.BackgroundTransparency = 1
        local d = Instance.new("TextLabel", f)
        d.Size = UDim2.new(1, -80, 0, 25)
        d.Position = UDim2.new(0, 15, 0, 32)
        d.Text = desc
        d.TextColor3 = Color3.fromRGB(140, 140, 160)
        d.TextSize = 13
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.BackgroundTransparency = 1
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(0, 48, 0, 24)
        b.Position = UDim2.new(1, -65, 0.5, -12)
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        b.Text = ""
        Instance.new("UICorner", b, UDim.new(1, 0))
        local circ = Instance.new("Frame", b)
        circ.Size = UDim2.new(0, 16, 0, 16)
        circ.Position = UDim2.new(0, 4, 0.5, -8)
        circ.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        Instance.new("UICorner", circ, UDim.new(1, 0))
        b.MouseButton1Click:Connect(function() handleToggle(b, circ, name .. "_" .. title, callback) end)
    end

    function tabObj:AddDropdown(title, list, callback)
        local f = Instance.new("Frame", content)
        f.Size = UDim2.new(1, 0, 0, 50)
        f.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Instance.new("UICorner", f)
        local s = Instance.new("UIStroke", f)
        s.Thickness = 1
        table.insert(FexawLib.Elements.Accents, s)
        local btn = Instance.new("TextButton", f)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.Text = "   " .. title .. "  [ - ]"
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundTransparency = 1
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.SourceSansBold

        btn.MouseButton1Click:Connect(function()
            local overlay = Instance.new("TextButton", FexawLib.sg)
            overlay.Size = UDim2.new(1, 0, 1, 0)
            overlay.BackgroundTransparency = 1
            overlay.Text = ""
            overlay.ZIndex = 500
            
            local dropFrame = Instance.new("Frame", FexawLib.sg)
            dropFrame.Size = UDim2.new(0, 300, 0, 350)
            dropFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
            dropFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
            dropFrame.ZIndex = 501
            Instance.new("UICorner", dropFrame)
            local ds = Instance.new("UIStroke", dropFrame)
            ds.Thickness = 2
            table.insert(FexawLib.Elements.Accents, ds)

            local si = Instance.new("TextBox", dropFrame)
            si.Size = UDim2.new(1, -20, 0, 35)
            si.Position = UDim2.new(0, 10, 0, 10)
            si.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            si.PlaceholderText = "Search..."
            si.Text = ""
            si.TextColor3 = Color3.new(1, 1, 1)
            si.ZIndex = 502
            Instance.new("UICorner", si)

            local sc = Instance.new("ScrollingFrame", dropFrame)
            sc.Size = UDim2.new(1, 0, 1, -60)
            sc.Position = UDim2.new(0, 0, 0, 55)
            sc.BackgroundTransparency = 1
            sc.ScrollBarThickness = 2
            sc.ZIndex = 502
            Instance.new("UIListLayout", sc)

            local function close() dropFrame:Destroy() overlay:Destroy() end
            overlay.MouseButton1Click:Connect(close)

            local function update(filter)
                for _, o in pairs(sc:GetChildren()) do if o:IsA("TextButton") then o:Destroy() end end
                for _, v in pairs(list) do
                    if filter == "" or v:lower():find(filter:lower()) then
                        local ib = Instance.new("TextButton", sc)
                        ib.Size = UDim2.new(1, -10, 0, 35)
                        ib.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
                        ib.Text = v
                        ib.ZIndex = 503
                        ib.TextColor3 = Color3.fromRGB(200, 200, 220)
                        Instance.new("UICorner", ib)
                        ib.MouseButton1Click:Connect(function() btn.Text = "   " .. title .. "  [" .. v .. "]" pcall(callback, v) close() end)
                    end
                end
            end
            update("")
            si:GetPropertyChangedSignal("Text"):Connect(function() update(si.Text) end)
        end)
    end

    function tabObj:AddButton(text, desc, callback)
        local f = Instance.new("Frame", content)
        f.Size = UDim2.new(1, 0, 0, 55)
        f.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
        Instance.new("UICorner", f)
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(1, -20, 1, 0)
        b.Position = UDim2.new(0, 12, 0, 0)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.BackgroundTransparency = 1
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Font = Enum.Font.SourceSansBold
        local d = Instance.new("TextLabel", f)
        d.Size = UDim2.new(1, -20, 0, 20)
        d.Position = UDim2.new(0, 12, 0, 30)
        d.Text = desc
        d.TextColor3 = Color3.fromRGB(140, 140, 160)
        d.TextSize = 12
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.BackgroundTransparency = 1
        b.MouseButton1Click:Connect(function() pcall(callback) end)
    end

    function tabObj:CreateCategory(cN)
        local lab = Instance.new("TextLabel", content)
        lab.Size = UDim2.new(1, 0, 0, 20)
        lab.Text = "• " .. cN:upper()
        lab.BackgroundTransparency = 1
        lab.TextColor3 = Color3.fromRGB(100, 100, 125)
        lab.TextXAlignment = Enum.TextXAlignment.Left
        lab.Font = Enum.Font.SourceSansBold
        lab.TextSize = 13
        return tabObj
    end

    return tabObj
end

return FexawLib
