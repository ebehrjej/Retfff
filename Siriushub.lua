FexawLib = {
    SaveData = {},
    States = {},
    Cooldowns = {},
    Elements = {Accents = {}, Backgrounds = {}, Texts = {}},
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
        Ruby = Color3.fromRGB(220, 20, 60),
        Candy = Color3.fromRGB(255, 0, 150),
        Forest = Color3.fromRGB(34, 139, 34),
        Sky = Color3.fromRGB(135, 206, 235),
        Amethyst = Color3.fromRGB(153, 102, 204),
        Bronze = Color3.fromRGB(205, 127, 50),
        Platinum = Color3.fromRGB(229, 228, 226)
    }
}

-- ГЕНЕРАТОР ТЕМ (ИТОГО 150+)
for i = 1, 132 do
    FexawLib.Themes["Official_Palette_" .. i] = Color3.fromHSV(i / 132, 0.7, 1)
end

function FexawLib:SaveConfig()
    local success, json = pcall(function() return game:GetService("HttpService"):JSONEncode(self.SaveData) end)
    if success then writefile("Fexaw_Config.json", json) end
end

function FexawLib:SetTheme(n)
    local TS = game:GetService("TweenService")
    local c = self.Themes[n] or self.Themes.Neon
    if self.RainbowLoop then self.RainbowLoop:Disconnect() self.RainbowLoop = nil end
    
    if n == "Rainbow" then
        self.RainbowLoop = game:GetService("RunService").RenderStepped:Connect(function()
            local clr = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            for _, s in pairs(self.Elements.Accents) do if s.ClassName == "UIStroke" then s.Color = clr else s.BackgroundColor3 = clr end end
        end)
    else
        for _, s in pairs(self.Elements.Accents) do
            if s.ClassName == "UIStroke" then TS:Create(s, TweenInfo.new(0.5), {Color = c}):Play() 
            elseif s.ClassName == "TextLabel" or s.ClassName == "TextButton" then TS:Create(s, TweenInfo.new(0.5), {TextColor3 = c}):Play()
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
                if not FexawLib.Cooldowns[stateKey] or (tick() - FexawLib.Cooldowns[stateKey]) > 0.5 then
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
    sg.Name = "Fexaw_Official_V10"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 620, 0, 420), UDim2.new(0.5, -310, 0.5, -210)
    main.BackgroundColor3, main.ClipsDescendants = Color3.fromRGB(12, 12, 18), true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    local ms = Instance.new("UIStroke", main) ms.Thickness = 2 table.insert(self.Elements.Accents, ms)

    -- SIDEBAR
    local side = Instance.new("Frame", main)
    side.Size, side.BackgroundColor3 = UDim2.new(0, 180, 1, 0), Color3.fromRGB(18, 18, 26)
    Instance.new("UICorner", side).CornerRadius = UDim.new(0, 12)

    local logo = Instance.new("TextLabel", side)
    logo.Size, logo.Position = UDim2.new(1, 0, 0, 60), UDim2.new(0, 20, 0, 0)
    logo.Text, logo.TextColor3, logo.TextXAlignment = "FEXAW HUB", Color3.new(1,1,1), Enum.TextXAlignment.Left
    logo.Font, logo.TextSize, logo.BackgroundTransparency = Enum.Font.SourceSansBold, 22, 1
    table.insert(self.Elements.Accents, logo)

    local tabScroll = Instance.new("ScrollingFrame", side)
    tabScroll.Size, tabScroll.Position = UDim2.new(1, 0, 1, -80), UDim2.new(0, 0, 0, 70)
    tabScroll.BackgroundTransparency, tabScroll.ScrollBarThickness = 1, 0
    local tabLayout = Instance.new("UIListLayout", tabScroll)
    tabLayout.Padding, tabLayout.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center

    -- TOPBAR
    local top = Instance.new("Frame", main)
    top.Size, top.Position, top.BackgroundTransparency = UDim2.new(1, -180, 0, 50), UDim2.new(0, 180, 0, 0), 1
    local topInfo = Instance.new("TextLabel", top)
    topInfo.Size, topInfo.Position = UDim2.new(1, -150, 1, 0), UDim2.new(0, 20, 0, 0)
    topInfo.Text, topInfo.TextColor3, topInfo.TextXAlignment = "Premium Edition | ThunderZ", Color3.fromRGB(150, 150, 160), Enum.TextXAlignment.Left
    topInfo.BackgroundTransparency, topInfo.Font = 1, Enum.Font.SourceSans

    local ctrl = Instance.new("Frame", top)
    ctrl.Size, ctrl.Position, ctrl.BackgroundTransparency = UDim2.new(0, 120, 1, 0), UDim2.new(1, -130, 0, 0), 1
    local function addCtrl(txt, pos, clr)
        local b = Instance.new("TextButton", ctrl)
        b.Size, b.Position, b.Text, b.TextColor3 = UDim2.new(0, 30, 0, 30), pos, txt, clr
        b.BackgroundTransparency, b.TextSize = 1, 18 return b
    end
    local X = addCtrl("X", UDim2.new(1, -35, 0, 10), Color3.new(1,0.2,0.2))
    local M = addCtrl("-", UDim2.new(1, -75, 0, 10), Color3.new(1,1,1))

    -- TOGGLE BUTTON
    local tgl = Instance.new("Frame", sg)
    tgl.Size, tgl.Position, tgl.BackgroundColor3 = UDim2.new(0, 60, 0, 60), UDim2.new(0.02, 0, 0.5, -30), Color3.fromRGB(20, 20, 30)
    Instance.new("UICorner", tgl, UDim.new(1, 0))
    local tglS = Instance.new("UIStroke", tgl) tglS.Thickness = 2 table.insert(self.Elements.Accents, tglS)
    local tglB = Instance.new("TextButton", tgl)
    tglB.Size, tglB.Text, tglB.TextColor3, tglB.BackgroundTransparency = UDim2.new(1,0,1,0), "FX", Color3.new(1,1,1), 1
    tglB.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

    X.MouseButton1Click:Connect(function() sg:Destroy() end)
    M.MouseButton1Click:Connect(function() main.Visible = false end)

    -- DRAG
    local drag, dS, sP
    main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dS, sP = true, i.Position, main.Position end end)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dS
        main.Position = UDim2.new(sP.X.Scale, sP.X.Offset + delta.X, sP.Y.Scale, sP.Y.Offset + delta.Y)
    end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

    self.mainFrame, self.tabScroll, self.Tabs = main, tabScroll, {}

    -- АВТО-ВКЛАДКА SETTINGS
    local SetTab = self:CreateTab("Settings")
    SetTab:AddButton("Save Configuration", "Save all current states to file", function() self:SaveConfig() end)
    local ThCat = SetTab:CreateCategory("Theme Engine")
    ThCat:AddButton("Rainbow Dynamic", "Cycle through all colors", function() self:SetTheme("Rainbow") end)
    local sorted = {} for n in pairs(self.Themes) do table.insert(sorted, n) end table.sort(sorted)
    for _, n in ipairs(sorted) do ThCat:AddButton(n, "Switch to " .. n .. " style", function() self:SetTheme(n) end) end

    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local btn = Instance.new("TextButton", self.tabScroll)
    btn.Size, btn.BackgroundColor3 = UDim2.new(0.9, 0, 0, 38), Color3.fromRGB(25, 25, 35)
    btn.Text, btn.TextColor3 = "    " .. name, Color3.fromRGB(180, 180, 190)
    btn.TextXAlignment, btn.Font = Enum.TextXAlignment.Left, Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    local bs = Instance.new("UIStroke", btn) bs.Thickness, bs.Transparency = 1, 0.8 table.insert(FexawLib.Elements.Accents, bs)

    local content = Instance.new("ScrollingFrame", self.mainFrame)
    content.Position, content.Size = UDim2.new(0, 195, 0, 60), UDim2.new(1, -210, 1, -75)
    content.BackgroundTransparency, content.Visible, content.ScrollBarThickness = 1, false, 0
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", content).Padding = UDim.new(0, 10)

    table.insert(self.Tabs, {Btn = btn, Cont = content})
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do t.Cont.Visible, t.Btn.TextColor3 = false, Color3.fromRGB(180,180,190) end
        content.Visible, btn.TextColor3 = true, Color3.new(1,1,1)
    end)

    local tabObj = {}

    function tabObj:AddToggle(title, desc, callback)
        local f = Instance.new("Frame", content)
        f.Size, f.BackgroundColor3 = UDim2.new(1, 0, 0, 60), Color3.fromRGB(22, 22, 30)
        Instance.new("UICorner", f)
        local t = Instance.new("TextLabel", f)
        t.Size, t.Position, t.Text = UDim2.new(1, -70, 0, 30), UDim2.new(0, 15, 0, 5), title
        t.TextColor3, t.Font, t.TextXAlignment, t.BackgroundTransparency = Color3.new(1,1,1), Enum.Font.SourceSansBold, Enum.TextXAlignment.Left, 1
        local d = Instance.new("TextLabel", f)
        d.Size, d.Position, d.Text = UDim2.new(1, -70, 0, 20), UDim2.new(0, 15, 0, 30), desc
        d.TextColor3, d.TextSize, d.TextXAlignment, d.BackgroundTransparency = Color3.fromRGB(150,150,160), 13, Enum.TextXAlignment.Left, 1
        local btn = Instance.new("TextButton", f)
        btn.Size, btn.Position = UDim2.new(0, 45, 0, 22), UDim2.new(1, -60, 0.5, -11)
        btn.BackgroundColor3, btn.Text = Color3.fromRGB(50,50,60), "" Instance.new("UICorner", btn, UDim.new(1,0))
        local circ = Instance.new("Frame", btn)
        circ.Size, circ.Position, circ.BackgroundColor3 = UDim2.new(0, 14, 0, 14), UDim2.new(0, 4, 0.5, -7), Color3.fromRGB(150,150,150)
        Instance.new("UICorner", circ, UDim.new(1,0))
        btn.MouseButton1Click:Connect(function() handleToggle(btn, circ, name.."_"..title, callback) end)
    end

    function tabObj:AddDropdown(title, options, callback)
        local f = Instance.new("Frame", content)
        f.Size, f.BackgroundColor3, f.ClipsDescendants = UDim2.new(1, 0, 0, 45), Color3.fromRGB(22, 22, 30), true
        Instance.new("UICorner", f)
        local btn = Instance.new("TextButton", f)
        btn.Size, btn.Text, btn.TextColor3, btn.BackgroundTransparency = UDim2.new(1,0,0,45), "  " .. title .. "  [ - ]", Color3.new(1,1,1), 1
        btn.TextXAlignment, btn.Font = Enum.TextXAlignment.Left, Enum.Font.SourceSansBold
        
        local listFrame = Instance.new("Frame", f)
        listFrame.Size, listFrame.Position, listFrame.BackgroundTransparency = UDim2.new(1,0,0,250), UDim2.new(0,0,0,45), 1
        local search = Instance.new("TextBox", listFrame)
        search.Size, search.Position, search.BackgroundColor3 = UDim2.new(1,-20,0,30), UDim2.new(0,10,0,5), Color3.fromRGB(30,30,40)
        search.PlaceholderText, search.Text, search.TextColor3 = "Search...", "", Color3.new(1,1,1) Instance.new("UICorner", search)
        
        local sc = Instance.new("ScrollingFrame", listFrame)
        sc.Size, sc.Position, sc.BackgroundTransparency, sc.ScrollBarThickness = UDim2.new(1,0,1,-40), UDim2.new(0,0,0,40), 1, 0
        Instance.new("UIListLayout", sc)

        local function update(filter)
            for _, o in pairs(sc:GetChildren()) do if o:IsA("TextButton") then o:Destroy() end end
            for _, v in pairs(options) do
                if filter == "" or v:lower():find(filter:lower()) then
                    local ib = Instance.new("TextButton", sc)
                    ib.Size, ib.BackgroundColor3, ib.Text = UDim2.new(1, -10, 0, 30), Color3.fromRGB(30,30,45), v
                    ib.TextColor3 = Color3.fromRGB(200,200,210) Instance.new("UICorner", ib)
                    ib.MouseButton1Click:Connect(function()
                        btn.Text = "  " .. title .. "  [" .. v .. "]"
                        f.Size = UDim2.new(1,0,0,45) pcall(callback, v)
                    end)
                end
            end
        end
        btn.MouseButton1Click:Connect(function()
            f.Size = f.Size.Y.Offset == 45 and UDim2.new(1,0,0,300) or UDim2.new(1,0,0,45)
            if f.Size.Y.Offset > 45 then update("") end
        end)
        search:GetPropertyChangedSignal("Text"):Connect(function() update(search.Text) end)
    end

    function tabObj:CreateCategory(cN)
        local lab = Instance.new("TextLabel", content)
        lab.Size, lab.Text = UDim2.new(1, 0, 0, 20), "• " .. cN:upper()
        lab.BackgroundTransparency, lab.TextColor3, lab.TextXAlignment = 1, Color3.fromRGB(100, 100, 120), Enum.TextXAlignment.Left
        lab.Font, lab.TextSize = Enum.Font.SourceSansBold, 13
        return tabObj
    end

    function tabObj:AddButton(text, desc, callback)
        local f = Instance.new("Frame", content)
        f.Size, f.BackgroundColor3 = UDim2.new(1, 0, 0, 50), Color3.fromRGB(25, 25, 35)
        Instance.new("UICorner", f)
        local b = Instance.new("TextButton", f)
        b.Size, b.BackgroundTransparency, b.Text, b.TextColor3 = UDim2.new(1,0,1,0), 1, "      " .. text, Color3.new(1,1,1)
        b.TextXAlignment, b.Font = Enum.TextXAlignment.Left, Enum.Font.SourceSansBold
        b.MouseButton1Click:Connect(function() pcall(callback) end)
    end

    return tabObj
end

return FexawLib
