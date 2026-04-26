FexawLib = {
    SaveData = {},
    States = {},
    Cooldowns = {},
    Elements = {},
    Tabs = {},
    Themes = {
        Neon = Color3.fromRGB(0, 255, 255), Fire = Color3.fromRGB(255, 50, 0), Water = Color3.fromRGB(0, 100, 255),
        Toxic = Color3.fromRGB(170, 255, 0), Matrix = Color3.fromRGB(0, 255, 70), Lava = Color3.fromRGB(255, 0, 0),
        Candy = Color3.fromRGB(255, 0, 200), Gold = Color3.fromRGB(255, 200, 0), Space = Color3.fromRGB(100, 0, 255),
        Midnight = Color3.fromRGB(25, 25, 50), Sky = Color3.fromRGB(0, 170, 255), Forest = Color3.fromRGB(30, 150, 30),
        Sun = Color3.fromRGB(255, 255, 0), Blood = Color3.fromRGB(150, 0, 0), Mint = Color3.fromRGB(150, 255, 200),
        Desert = Color3.fromRGB(230, 190, 130), Ice = Color3.fromRGB(200, 240, 255), Void = Color3.fromRGB(10, 10, 10),
        Wine = Color3.fromRGB(120, 0, 40), Sakura = Color3.fromRGB(255, 180, 200), Lime = Color3.fromRGB(100, 255, 0),
        Orange = Color3.fromRGB(255, 120, 0), Purple = Color3.fromRGB(180, 0, 255), Ocean = Color3.fromRGB(0, 80, 150),
        Emerald = Color3.fromRGB(0, 200, 100), Ruby = Color3.fromRGB(220, 20, 60), Sapphire = Color3.fromRGB(15, 82, 186),
        Platinum = Color3.fromRGB(229, 228, 226), Bronze = Color3.fromRGB(205, 127, 50), Copper = Color3.fromRGB(184, 115, 51)
    }
}

for i = 1, 120 do FexawLib.Themes["Shade_" .. i] = Color3.fromHSV(i / 120, 0.7, 1) end

local function handleToggleLogic(instance, stateKey, callback)
    local active = not FexawLib.States[stateKey]
    FexawLib.States[stateKey] = active
    game:GetService("TweenService"):Create(instance, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(40, 40, 40)}):Play()
    if active then
        task.spawn(function()
            while FexawLib.States[stateKey] do
                local now = tick()
                if not FexawLib.Cooldowns[stateKey] or (now - FexawLib.Cooldowns[stateKey]) > 0.4 then
                    FexawLib.Cooldowns[stateKey] = now
                    pcall(callback)
                end
                task.wait(0.1)
            end
        end)
    end
end

function FexawLib:SetTheme(n)
    local TS = game:GetService("TweenService")
    if self.RainbowLoop then self.RainbowLoop:Disconnect() self.RainbowLoop = nil end
    if n == "Rainbow" then
        self.RainbowLoop = game:GetService("RunService").RenderStepped:Connect(function()
            local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            for _, s in pairs(self.Elements) do s.Color = c end
        end)
    elseif self.Themes[n] then
        local c = self.Themes[n]
        for _, s in pairs(self.Elements) do TS:Create(s, TweenInfo.new(0.5), {Color = c}):Play() end
    end
end

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game:GetService("Players").LocalPlayer
    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "FexawV5_Pro"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 520, 0, 380), UDim2.new(0.5, -260, 0.5, -190)
    main.BackgroundColor3, main.Visible, main.ClipsDescendants = Color3.fromRGB(15, 15, 15), false, true
    Instance.new("UICorner", main)
    local ms = Instance.new("UIStroke", main) ms.Thickness = 3
    table.insert(self.Elements, ms)

    local DragL = Instance.new("Frame", main)
    DragL.Size, DragL.BackgroundColor3, DragL.BackgroundTransparency = UDim2.new(0, 7, 1, 0), Color3.new(1, 1, 1), 0.9
    Instance.new("UICorner", DragL)
    local DragR = Instance.new("Frame", main)
    DragR.Size, DragR.Position, DragR.BackgroundColor3, DragR.BackgroundTransparency = UDim2.new(0, 7, 1, 0), UDim2.new(1, -7, 0, 0), Color3.new(1, 1, 1), 0.9
    Instance.new("UICorner", DragR)

    local TopBar = Instance.new("Frame", main)
    TopBar.Size, TopBar.Position, TopBar.BackgroundTransparency = UDim2.new(1, -160, 0, 35), UDim2.new(0, 160, 0, 0), 1
    local SearchBtn = Instance.new("TextButton", TopBar)
    SearchBtn.Size, SearchBtn.Position, SearchBtn.Text, SearchBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -110, 0, 5), "🔍", 1
    local MinusBtn = Instance.new("TextButton", TopBar)
    MinusBtn.Size, MinusBtn.Position, MinusBtn.Text, MinusBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -75, 0, 5), "-", 1
    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size, CloseBtn.Position, CloseBtn.Text, CloseBtn.TextColor3, CloseBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -40, 0, 5), "X", Color3.fromRGB(255, 50, 50), 1

    local SF = Instance.new("Frame", main)
    SF.Size, SF.Position, SF.BackgroundColor3, SF.Visible = UDim2.new(0, 0, 0, 30), UDim2.new(0, 170, 0, 40), Color3.fromRGB(25, 25, 25), false
    Instance.new("UICorner", SF)
    local SI = Instance.new("TextBox", SF)
    SI.Size, SI.BackgroundTransparency, SI.PlaceholderText, SI.Text = UDim2.new(1, -10, 1, 0), 1, "Search...", ""
    SI.TextColor3 = Color3.new(1, 1, 1)

    local Confirm = Instance.new("Frame", sg)
    Confirm.Size, Confirm.Position, Confirm.BackgroundColor3, Confirm.Visible = UDim2.new(0, 300, 0, 120), UDim2.new(0.5, -150, 0.5, -60), Color3.fromRGB(30, 30, 30), false
    Instance.new("UICorner", Confirm)
    local cs = Instance.new("UIStroke", Confirm) cs.Thickness = 2 table.insert(self.Elements, cs)
    local confTxt = Instance.new("TextLabel", Confirm) confTxt.Size, confTxt.Text = UDim2.new(1, 0, 0, 60), "Close menu?"
    confTxt.TextColor3, confTxt.BackgroundTransparency = Color3.new(1,1,1), 1
    local Yes = Instance.new("TextButton", Confirm) Yes.Size, Yes.Position, Yes.Text, Yes.BackgroundColor3 = UDim2.new(0, 100, 0, 35), UDim2.new(0.1, 0, 0.6, 0), "Yes", Color3.fromRGB(0, 150, 0)
    Instance.new("UICorner", Yes)
    local No = Instance.new("TextButton", Confirm) No.Size, No.Position, No.Text, No.BackgroundColor3 = UDim2.new(0, 100, 0, 35), UDim2.new(0.55, 0, 0.6, 0), "No", Color3.fromRGB(150, 0, 0)
    Instance.new("UICorner", No)

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position, ob.BackgroundColor3, ob.BackgroundTransparency = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.1, 0), Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local os = Instance.new("UIStroke", ob) os.Thickness = 2 table.insert(self.Elements, os)
    local db = Instance.new("TextButton", ob) db.Size, db.BackgroundTransparency, db.Text, db.TextColor3, db.TextSize = UDim2.new(0, 60, 1, 0), 1, "÷  |", Color3.new(1, 1, 1), 22
    local obn = Instance.new("TextButton", ob) obn.Size, obn.Position, obn.Text, obn.BackgroundTransparency, obn.TextColor3 = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0), "FEXAW | MENU", 1, Color3.new(1, 1, 1)

    local drag, dS, sP, mSP
    local function iD(g, t) g.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dS, sP, mSP = true, i.Position, t.Position, main.Position end end) end
    iD(DragL, main) iD(DragR, main) iD(db, ob)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dS
        ob.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y)
        main.Position = UDim2.new(mSP.X.Scale, mSP.X.Offset + d.X, mSP.Y.Scale, mSP.Y.Offset + d.Y)
    end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

    local function tM() main.Visible = not main.Visible end
    obn.MouseButton1Click:Connect(tM) MinusBtn.MouseButton1Click:Connect(tM)
    CloseBtn.MouseButton1Click:Connect(function() Confirm.Visible = true end)
    No.MouseButton1Click:Connect(function() Confirm.Visible = false end)
    Yes.MouseButton1Click:Connect(function() sg:Destroy() end)
    SearchBtn.MouseButton1Click:Connect(function() SF.Visible = not SF.Visible SF.Size = SF.Visible and UDim2.new(1, -180, 0, 30) or UDim2.new(0, 0, 0, 30) end)

    SI:GetPropertyChangedSignal("Text"):Connect(function()
        local t = SI.Text:lower()
        for _, tab in pairs(self.Tabs) do
            for _, o in pairs(tab.Cont:GetDescendants()) do
                if o:IsA("TextButton") and o.Parent:IsA("Frame") and not o.Parent:IsA("ScrollingFrame") then
                    o.Parent.Visible = t == "" or o.Text:lower():find(t)
                end
            end
        end
    end)

    self.mainFrame, self.sideBar = main, Instance.new("Frame", main)
    self.sideBar.Size, self.sideBar.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", self.sideBar)
    Instance.new("UIListLayout", self.sideBar).HorizontalAlignment = Enum.HorizontalAlignment.Center
    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local tb = Instance.new("TextButton", self.sideBar)
    tb.Size, tb.BackgroundColor3, tb.Text, tb.TextColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30), name, Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", tb)
    local cn = Instance.new("ScrollingFrame", self.mainFrame)
    cn.Position, cn.Size, cn.Visible, cn.BackgroundTransparency = UDim2.new(0, 160, 0, 45), UDim2.new(1, -170, 1, -55), false, 1
    cn.ScrollBarThickness, cn.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", cn).Padding = UDim.new(0, 5)
    table.insert(self.Tabs, {Btn = tb, Cont = cn})
    tb.MouseButton1Click:Connect(function() for _, t in pairs(self.Tabs) do t.Cont.Visible = false end cn.Visible = true end)

    local tabObj = {}
    function tabObj:AddToggle(txt, callback)
        local fr = Instance.new("Frame", cn) fr.Size, fr.BackgroundTransparency = UDim2.new(1, -10, 0, 30), 1
        local b = Instance.new("TextButton", fr) b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 1, 0), Color3.fromRGB(40, 40, 40), txt, Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        local sKey = name .. "_" .. txt
        b.MouseButton1Click:Connect(function() handleToggleLogic(b, sKey, callback) end)
    end

    function tabObj:CreateCategory(cN)
        local cf = Instance.new("Frame", cn) cf.Size, cf.AutomaticSize, cf.BackgroundTransparency = UDim2.new(1, -10, 0, 32), Enum.AutomaticSize.Y, 1
        Instance.new("UIListLayout", cf).Padding = UDim.new(0, 5)
        local fb = Instance.new("TextButton", cf) fb.Size, fb.BackgroundColor3, fb.Text, fb.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(35, 35, 35), "v " .. cN .. " v", Color3.new(1, 1, 1)
        Instance.new("UICorner", fb)
        local f = Instance.new("Frame", cf) f.Size, f.AutomaticSize, f.BackgroundTransparency, f.Visible = UDim2.new(1, 0, 0, 0), Enum.AutomaticSize.Y, 1, false
        Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
        fb.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
        local catObj = {}
        function catObj:AddToggle(txt, callback)
            local fr = Instance.new("Frame", f) fr.Size, fr.BackgroundTransparency = UDim2.new(1, 0, 0, 30), 1
            local b = Instance.new("TextButton", fr) b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 1, 0), Color3.fromRGB(40, 40, 40), txt, Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            local sKey = name .. "_" .. cN .. "_" .. txt
            b.MouseButton1Click:Connect(function() handleToggleLogic(b, sKey, callback) end)
        end
        function catObj:AddButton(txt, cb)
            local b = Instance.new("TextButton", f) b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(45, 45, 45), txt, Color3.new(1, 1, 1)
            Instance.new("UICorner", b) b.MouseButton1Click:Connect(function() pcall(cb) end)
        end
        return catObj
    end

    function tabObj:AddSlider(txt, min, max, def, cb)
        local fr = Instance.new("Frame", cn) fr.Size, fr.BackgroundColor3 = UDim2.new(1, -10, 0, 45), Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", fr)
        local l = Instance.new("TextLabel", fr) l.Size, l.Position, l.Text, l.BackgroundTransparency = UDim2.new(1, 0, 0, 20), UDim2.new(0, 5, 0, 0), txt .. ": " .. def, 1
        l.TextColor3 = Color3.new(1, 1, 1)
        local bar = Instance.new("Frame", fr) bar.Size, bar.Position, bar.BackgroundColor3 = UDim2.new(0.9, 0, 0, 5), UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(50, 50, 50)
        local fill = Instance.new("Frame", bar) fill.Size, fill.BackgroundColor3 = UDim2.new((def - min) / (max - min), 0, 1, 0), Color3.fromRGB(0, 200, 255)
        local d = false
        local function upd()
            local m = game:GetService("UserInputService"):GetMouseLocation().X
            local p = math.clamp((m - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max - min) * p)
            fill.Size, l.Text = UDim2.new(p, 0, 1, 0), txt .. ": " .. v
            pcall(cb, v)
        end
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true end end)
        game:GetService("UserInputService").InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
        game:GetService("UserInputService").InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then upd() end end)
    end

    function tabObj:AddDropdown(txt, list, cb)
        local fr = Instance.new("Frame", cn) fr.Size, fr.BackgroundColor3, fr.AutomaticSize = UDim2.new(1, -10, 0, 30), Color3.fromRGB(35, 35, 35), Enum.AutomaticSize.Y
        Instance.new("UICorner", fr)
        local btn = Instance.new("TextButton", fr) btn.Size, btn.Text, btn.BackgroundColor3, btn.TextColor3 = UDim2.new(1, 0, 0, 30), txt .. " ▼", Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
        Instance.new("UICorner", btn)
        local drop = Instance.new("Frame", fr) drop.Size, drop.Position, drop.Visible, drop.BackgroundTransparency = UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 0, 30), false, 1
        drop.AutomaticSize = Enum.AutomaticSize.Y Instance.new("UIListLayout", drop)
        btn.MouseButton1Click:Connect(function() drop.Visible = not drop.Visible end)
        for _, v in pairs(list) do
            local ib = Instance.new("TextButton", drop) ib.Size, ib.Text, ib.BackgroundColor3, ib.TextColor3 = UDim2.new(1, 0, 0, 25), v, Color3.fromRGB(55, 55, 55), Color3.new(0.8, 0.8, 0.8)
            ib.MouseButton1Click:Connect(function() btn.Text, drop.Visible = v .. " ▼", false pcall(cb, v) end)
        end
    end

    function tabObj:AddButton(txt, cb)
        local fr = Instance.new("Frame", cn) fr.Size, fr.BackgroundTransparency = UDim2.new(1, -10, 0, 30), 1
        local b = Instance.new("TextButton", fr) b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 1, 0), Color3.fromRGB(45, 45, 45), txt, Color3.new(1, 1, 1)
        Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
    end

    return tabObj
end

return FexawLib
