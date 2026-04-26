local FexawLib = {}

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520
    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint, main.BackgroundColor3 = Vector2.new(0.5, 0.5), Color3.fromRGB(15, 15, 15)
    main.Visible, main.ClipsDescendants = false, true 
    Instance.new("UICorner", main)
    local ms = Instance.new("UIStroke", main)
    ms.Thickness, ms.ApplyStrokeMode, ms.Color = 3, Enum.ApplyStrokeMode.Border, Color3.fromRGB(50, 50, 50)

    local side = Instance.new("Frame", main)
    side.Size, side.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)
    local sl = Instance.new("UIListLayout", side)
    sl.Padding, sl.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center
    local ss = Instance.new("UIStroke", side)
    ss.Thickness, ss.ApplyStrokeMode, ss.Color = 2, Enum.ApplyStrokeMode.Border, Color3.fromRGB(40, 40, 40)

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local os = Instance.new("UIStroke", ob)
    os.Thickness, os.Color = 2, Color3.fromRGB(60, 60, 60)

    local db = Instance.new("TextButton", ob)
    db.Size, db.BackgroundTransparency, db.Text = UDim2.new(0, 60, 1, 0), 1, "÷  |"
    db.TextColor3, db.TextSize = Color3.new(1, 1, 1), 22

    local obn = Instance.new("TextButton", ob)
    obn.Size, obn.Position = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0)
    obn.BackgroundTransparency, obn.Text = 1, "FEXAW | MENU"
    obn.TextColor3, obn.TextXAlignment = Color3.new(1, 1, 1), Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, mainStartPos
    db.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos, mainStartPos = true, input.Position, ob.Position, main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            main.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + delta.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + delta.Y)
        end
    end)

    obn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play() tw.Completed:Connect(function() if main.Size.Y.Offset < 10 then main.Visible = false end end)
        end
    end)

    function self:ChangeTheme(mainC, sideC, strokeC)
        TS:Create(main, TweenInfo.new(0.3), {BackgroundColor3 = mainC}):Play()
        TS:Create(side, TweenInfo.new(0.3), {BackgroundColor3 = sideC}):Play()
        TS:Create(ms, TweenInfo.new(0.3), {Color = strokeC}):Play()
        TS:Create(ss, TweenInfo.new(0.3), {Color = strokeC}):Play()
        TS:Create(os, TweenInfo.new(0.3), {Color = strokeC}):Play()
    end

    self.allTabs = {}
    self.sg, self.side, self.main = sg, side, main
    
    local st = self:CreateTab("Settings")
    local sc = st:CreateCategory("Themes")
    
    local themes = {
        ["Neon Blue"] = {Color3.fromRGB(10, 10, 20), Color3.fromRGB(15, 15, 30), Color3.fromRGB(0, 150, 255)},
        ["Neon Red"] = {Color3.fromRGB(20, 10, 10), Color3.fromRGB(30, 15, 15), Color3.fromRGB(255, 50, 50)},
        ["Neon Green"] = {Color3.fromRGB(10, 20, 10), Color3.fromRGB(15, 30, 15), Color3.fromRGB(50, 255, 50)},
        ["Purple Night"] = {Color3.fromRGB(15, 10, 20), Color3.fromRGB(20, 15, 30), Color3.fromRGB(180, 50, 255)},
        ["Midnight"] = {Color3.fromRGB(5, 5, 5), Color3.fromRGB(10, 10, 10), Color3.fromRGB(40, 40, 40)},
        ["Sakura"] = {Color3.fromRGB(25, 15, 20), Color3.fromRGB(35, 20, 25), Color3.fromRGB(255, 150, 200)},
        ["Ocean"] = {Color3.fromRGB(10, 20, 25), Color3.fromRGB(15, 25, 35), Color3.fromRGB(0, 200, 255)},
        ["Gold"] = {Color3.fromRGB(20, 20, 10), Color3.fromRGB(30, 30, 15), Color3.fromRGB(255, 200, 0)},
        ["Vampire"] = {Color3.fromRGB(15, 0, 0), Color3.fromRGB(25, 0, 0), Color3.fromRGB(150, 0, 0)},
        ["Toxic"] = {Color3.fromRGB(10, 25, 10), Color3.fromRGB(15, 35, 15), Color3.fromRGB(180, 255, 0)}
    }

    for name, colors in pairs(themes) do
        sc:AddButton(name, function() self:ChangeTheme(colors[1], colors[2], colors[3]) end)
    end

    for i = 1, 50 do
        local h = (i-1)/50
        local c = Color3.fromHSV(h, 0.7, 1)
        sc:AddButton("Preset "..i, function() self:ChangeTheme(Color3.fromRGB(15,15,15), Color3.fromRGB(20,20,20), c) end)
    end

    return self
end

function FexawLib:CreateTab(name)
    local tb = Instance.new("TextButton", self.side)
    tb.Size, tb.BackgroundColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30)
    tb.Text, tb.TextColor3 = name, Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", tb)

    local cn = Instance.new("ScrollingFrame", self.main)
    cn.Position, cn.Size = UDim2.new(0, 160, 0, 10), UDim2.new(1, -170, 1, -20)
    cn.BackgroundTransparency, cn.Visible = 1, false
    cn.ScrollBarThickness, cn.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", cn).Padding = UDim.new(0, 5)
    
    table.insert(self.allTabs, {Btn = tb, Cont = cn})
    tb.MouseButton1Click:Connect(function()
        for _, t in pairs(self.allTabs) do 
            t.Cont.Visible = false 
            game:GetService("TweenService"):Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.new(0.7, 0.7, 0.7)}):Play()
        end
        cn.Visible = true
        game:GetService("TweenService"):Create(tb, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50), TextColor3 = Color3.new(1, 1, 1)}):Play()
    end)

    local tab = {}
    local parentLib = self
    function tab:CreateCategory(n)
        local frame = Instance.new("Frame", cn)
        frame.Size, frame.BackgroundTransparency, frame.ClipsDescendants = UDim2.new(1, -10, 0, 30), 1, true
        local l = Instance.new("UIListLayout", frame) l.Padding = UDim.new(0, 5)
        local btn = Instance.new("TextButton", frame)
        btn.Size, btn.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(35, 35, 35)
        btn.Text, btn.TextColor3 = "▼ " .. n .. " ▼", Color3.new(1, 1, 1)
        Instance.new("UICorner", btn)
        local container = Instance.new("Frame", frame)
        container.Size, container.AutomaticSize, container.BackgroundTransparency = UDim2.new(1, 0, 0, 0), Enum.AutomaticSize.Y, 1
        Instance.new("UIListLayout", container).Padding = UDim.new(0, 5)
        local open = false
        btn.MouseButton1Click:Connect(function()
            open = not open
            local targetSize = open and UDim2.new(1, -10, 0, container.AbsoluteSize.Y + 35) or UDim2.new(1, -10, 0, 30)
            game:GetService("TweenService"):Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
            btn.Text = (open and "▲ " or "▼ ") .. n .. (open and " ▲" or " ▼")
        end)
        local cat = {}
        function cat:AddToggle(txt, cb)
            local b = Instance.new("TextButton", container)
            b.Size, b.Text = UDim2.new(1, 0, 0, 30), txt
            b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            local a = false
            b.MouseButton1Click:Connect(function()
                a = not a
                game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = a and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)}):Play()
                task.spawn(function() while a do pcall(cb) task.wait(0.3) end end)
            end)
        end
        function cat:AddButton(txt, cb)
            local b = Instance.new("TextButton", container)
            b.Size, b.Text = UDim2.new(1, 0, 0, 30), txt
            b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function()
                local old = b.BackgroundColor3
                b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                task.wait(0.1)
                b.BackgroundColor3 = old
                pcall(cb)
            end)
        end
        function cat:AddDropdown(txt, items, cb)
            local dFrame = Instance.new("Frame", container)
            dFrame.Size, dFrame.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", dFrame)
            local btnD = Instance.new("TextButton", dFrame)
            btnD.Size, btnD.BackgroundTransparency, btnD.Text = UDim2.new(1, 0, 1, 0), 1, txt .. "  ▼"
            btnD.TextColor3 = Color3.new(1, 1, 1)
            local list = Instance.new("ScrollingFrame", parentLib.sg)
            list.Visible, list.BackgroundColor3 = false, Color3.fromRGB(25, 25, 25)
            list.Size, list.ZIndex = UDim2.new(0, 200, 0, 0), 10
            list.ScrollBarThickness, list.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
            Instance.new("UIListLayout", list).Padding = UDim.new(0, 2)
            Instance.new("UICorner", list)
            local function upPos()
                list.Position = UDim2.new(0, dFrame.AbsolutePosition.X, 0, dFrame.AbsolutePosition.Y + 35)
            end
            btnD.MouseButton1Click:Connect(function()
                if not list.Visible then
                    upPos() list.Visible = true
                    game:GetService("TweenService"):Create(list, TweenInfo.new(0.3), {Size = UDim2.new(0, dFrame.AbsoluteSize.X, 0, 150)}):Play()
                else
                    local tw = game:GetService("TweenService"):Create(list, TweenInfo.new(0.2), {Size = UDim2.new(0, dFrame.AbsoluteSize.X, 0, 0)})
                    tw:Play() tw.Completed:Connect(function() if list.Size.Y.Offset < 10 then list.Visible = false end end)
                end
                btnD.Text = txt .. (not list.Visible and "  ▲" or "  ▼")
            end)
            for _, item in pairs(items) do
                local ib = Instance.new("TextButton", list)
                ib.Size, ib.BackgroundColor3, ib.BorderSizePixel = UDim2.new(1, 0, 0, 25), Color3.fromRGB(35, 35, 35), 0
                ib.Text, ib.TextColor3 = item, Color3.new(0.8, 0.8, 0.8)
                ib.MouseButton1Click:Connect(function()
                    btnD.Text = item .. "  ▼"
                    list.Visible = false
                    pcall(cb, item)
                end)
            end
        end
        return cat
    end
    return tab
end

return FexawLib
