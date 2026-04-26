local HS = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local p = game:GetService("Players").LocalPlayer

FexawLib = {SaveData = {}, Toggles = {}, ThemeColor = Color3.fromRGB(0, 255, 255)}

function FexawLib:SaveConfig()
    local s, j = pcall(function() return HS:JSONEncode(self.SaveData) end)
    if s then writefile("FexawConfig.json", j) end
end

function FexawLib:Init()
    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "FexawV4"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint, main.BackgroundColor3 = Vector2.new(0.5, 0.5), Color3.fromRGB(15, 15, 15)
    main.Visible, main.ClipsDescendants = false, true
    Instance.new("UICorner", main)
    local ms = Instance.new("UIStroke", main)
    ms.Thickness, ms.Color = 3, self.ThemeColor

    local top = Instance.new("Frame", main)
    top.Size, top.Position, top.BackgroundTransparency = UDim2.new(1, -160, 0, 35), UDim2.new(0, 160, 0, 0), 1

    local sBtn = Instance.new("TextButton", top)
    sBtn.Size, sBtn.Position, sBtn.Text, sBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -110, 0, 5), "🔍", 1
    sBtn.TextColor3 = Color3.new(1,1,1)

    local cBtn = Instance.new("TextButton", top)
    cBtn.Size, cBtn.Position, cBtn.Text, cBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -40, 0, 5), "X", 1
    cBtn.TextColor3 = Color3.fromRGB(255, 50, 50)

    local sf = Instance.new("Frame", main)
    sf.Size, sf.Position = UDim2.new(0, 0, 0, 30), UDim2.new(0, 170, 0, 40)
    sf.BackgroundColor3, sf.Visible, sf.ClipsDescendants = Color3.fromRGB(25, 25, 25), false, true
    Instance.new("UICorner", sf)
    local si = Instance.new("TextBox", sf)
    si.Size, si.BackgroundTransparency, si.Position = UDim2.new(1, -10, 1, 0), 1, UDim2.new(0, 5, 0, 0)
    si.PlaceholderText, si.TextColor3, si.Text = "Search...", Color3.new(1,1,1), ""

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local os = Instance.new("UIStroke", ob)
    os.Thickness, os.Color = 2, self.ThemeColor

    local db = Instance.new("TextButton", ob)
    db.Size, db.BackgroundTransparency, db.Text, db.TextColor3, db.TextSize = UDim2.new(0, 60, 1, 0), 1, "÷  |", Color3.new(1,1,1), 22
    local obn = Instance.new("TextButton", ob)
    obn.Size, obn.Position, obn.Text, obn.BackgroundTransparency = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0), "FEXAW | MENU", 1
    obn.TextColor3, obn.TextXAlignment = Color3.new(1,1,1), Enum.TextXAlignment.Left

    local drag, dS, sP, mSP
    db.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag,dS,sP,mSP = true,i.Position,ob.Position,main.Position end end)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dS
        ob.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y)
        main.Position = UDim2.new(mSP.X.Scale, mSP.X.Offset + d.X, mSP.Y.Scale, mSP.Y.Offset + d.Y)
    end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

    si:GetPropertyChangedSignal("Text"):Connect(function()
        local t = si.Text:lower()
        for _, tab in pairs(self.tabsList) do
            for _, o in pairs(tab.Cont:GetChildren()) do
                if o:IsA("Frame") or o:IsA("TextButton") then
                    o.Visible = t == "" or (o:FindFirstChild("TextButton") and o.TextButton.Text:lower():find(t)) or (o:IsA("TextButton") and o.Text:lower():find(t))
                end
            end
        end
    end)

    obn.MouseButton1Click:Connect(function() main.Visible = true TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 520, 0, 380)}):Play() end)
    sBtn.MouseButton1Click:Connect(function() sf.Visible = not sf.Visible TS:Create(sf, TweenInfo.new(0.3), {Size = sf.Visible and UDim2.new(1, -180, 0, 30) or UDim2.new(0, 0, 0, 30)}):Play() end)
    cBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

    self.main, self.side, self.tabsList = main, Instance.new("Frame", main), {}
    self.side.Size, self.side.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", self.side)
    local sl = Instance.new("UIListLayout", self.side)
    sl.Padding, sl.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center

    return self
end

function FexawLib:CreateTab(n)
    local tb = Instance.new("TextButton", self.side)
    tb.Size, tb.BackgroundColor3, tb.Text, tb.TextColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30), n, Color3.new(0.7,0.7,0.7)
    Instance.new("UICorner", tb)
    local cn = Instance.new("ScrollingFrame", self.main)
    cn.Position, cn.Size, cn.BackgroundTransparency, cn.Visible = UDim2.new(0, 160, 0, 45), UDim2.new(1, -170, 1, -55), 1, false
    cn.ScrollBarThickness, cn.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", cn).Padding = UDim.new(0, 5)
    table.insert(self.tabsList, {Btn = tb, Cont = cn})
    tb.MouseButton1Click:Connect(function() for _, t in pairs(self.tabsList) do t.Cont.Visible = false end cn.Visible = true end)

    local tab = {}
    function tab:AddToggle(t, cb)
        local b = Instance.new("TextButton", cn)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(40, 40, 40), t, Color3.new(1,1,1)
        Instance.new("UICorner", b)
        local id, act = t, false
        b.MouseButton1Click:Connect(function()
            act = not act
            FexawLib.Toggles[id] = act
            TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = act and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
            if act then task.spawn(function() while FexawLib.Toggles[id] do pcall(cb) task.wait(0.3) end end) end
        end)
    end

    function tab:AddSlider(t, min, max, def, cb)
        local f = Instance.new("Frame", cn)
        f.Size, f.BackgroundColor3 = UDim2.new(1, -10, 0, 45), Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f)
        l.Size, l.Position, l.Text, l.BackgroundTransparency = UDim2.new(1, 0, 0, 20), UDim2.new(0, 5, 0, 0), t .. ": " .. def, 1
        l.TextColor3, l.TextXAlignment = Color3.new(1,1,1), Enum.TextXAlignment.Left
        local bar = Instance.new("Frame", f)
        bar.Size, bar.Position, bar.BackgroundColor3 = UDim2.new(0.9, 0, 0, 5), UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(50, 50, 50)
        local fill = Instance.new("Frame", bar)
        fill.Size, fill.BackgroundColor3 = UDim2.new((def-min)/(max-min), 0, 1, 0), Color3.fromRGB(0, 200, 255)
        local drag = false
        local function upd()
            local m = UIS:GetMouseLocation().X
            local p = math.clamp((m - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max - min) * p)
            fill.Size, l.Text = UDim2.new(p, 0, 1, 0), t .. ": " .. v
            pcall(cb, v)
        end
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then upd() end end)
    end

    function tab:AddDropdown(t, list, cb)
        local f = Instance.new("Frame", cn)
        f.Size, f.BackgroundColor3, f.AutomaticSize = UDim2.new(1, -10, 0, 30), Color3.fromRGB(35, 35, 35), Enum.AutomaticSize.Y
        Instance.new("UICorner", f)
        local btn = Instance.new("TextButton", f)
        btn.Size, btn.Text, btn.BackgroundColor3, btn.TextColor3 = UDim2.new(1, 0, 0, 30), t .. " ▼", Color3.fromRGB(45, 45, 45), Color3.new(1,1,1)
        Instance.new("UICorner", btn)
        local c = Instance.new("Frame", f)
        c.Size, c.Position, c.Visible, c.BackgroundTransparency = UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 0, 30), false, 1
        c.AutomaticSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", c)
        btn.MouseButton1Click:Connect(function() c.Visible = not c.Visible end)
        for _, v in pairs(list) do
            local i = Instance.new("TextButton", c)
            i.Size, i.Text, i.BackgroundColor3, i.TextColor3 = UDim2.new(1, 0, 0, 25), v, Color3.fromRGB(55, 55, 55), Color3.new(0.8,0.8,0.8)
            i.MouseButton1Click:Connect(function() btn.Text, c.Visible = v .. " ▼", false pcall(cb, v) end)
        end
    end

    function tab:AddButton(t, cb)
        local b = Instance.new("TextButton", cn)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(45, 45, 45), t, Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(cb)
    end

    return tab
end

return FexawLib
