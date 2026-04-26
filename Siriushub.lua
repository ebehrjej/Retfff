FexawLib = {}

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520
    main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint, main.BackgroundColor3 = Vector2.new(0.5, 0.5), Color3.fromRGB(15, 15, 15)
    main.Visible, main.ClipsDescendants = false, true 
    Instance.new("UICorner", main)
    local ms = Instance.new("UIStroke", main)
    ms.Thickness, ms.ApplyStrokeMode = 3, Enum.ApplyStrokeMode.Border

    side = Instance.new("Frame", main)
    side.Size, side.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)
    local sl = Instance.new("UIListLayout", side)
    sl.Padding, sl.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center
    local ss = Instance.new("UIStroke", side)
    ss.Thickness, ss.ApplyStrokeMode = 2, Enum.ApplyStrokeMode.Border

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local os = Instance.new("UIStroke", ob)
    os.Thickness = 2

    task.spawn(function()
        local h = 0
        while true do
            local c = Color3.fromHSV(h, 1, 1)
            ms.Color, ss.Color, os.Color = c, c, c
            h = h + 0.005 task.wait(0.01)
        end
    end)

    local db = Instance.new("TextButton", ob)
    db.Size, db.BackgroundTransparency, db.Text = UDim2.new(0, 60, 1, 0), 1, "÷  |"
    db.TextColor3, db.TextSize = Color3.new(1, 1, 1), 22

    local obn = Instance.new("TextButton", ob)
    obn.Size, obn.Position = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0)
    obn.BackgroundTransparency, obn.Text = 1, "FEXAW | MENU"
    obn.TextColor3, obn.TextXAlignment = Color3.new(1, 1, 1), Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, mainStartPos
    local function update(input)
        local delta = input.Position - dragStart
        ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        main.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + delta.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + delta.Y)
    end
    db.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos, mainStartPos = true, input.Position, ob.Position, main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
    end)
    obn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play()
            tw.Completed:Connect(function() if main.Size.Y.Offset < 10 then main.Visible = false end end)
        end
    end)
    allTabs = {}
    return self
end

function FexawLib:CreateTab(name)
    local tb = Instance.new("TextButton", side)
    tb.Size, tb.BackgroundColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30)
    tb.Text, tb.TextColor3 = name, Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", tb)

    local cn = Instance.new("ScrollingFrame", main)
    cn.Position, cn.Size = UDim2.new(0, 160, 0, 10), UDim2.new(1, -170, 1, -20)
    cn.BackgroundTransparency, cn.Visible = 1, false
    cn.ScrollBarThickness, cn.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    local cl = Instance.new("UIListLayout", cn)
    cl.Padding, cl.SortOrder = UDim.new(0, 5), Enum.SortOrder.LayoutOrder

    table.insert(allTabs, {Btn = tb, Cont = cn})
    tb.MouseButton1Click:Connect(function()
        for _, t in pairs(allTabs) do 
            t.Cont.Visible = false 
            game:GetService("TweenService"):Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.new(0.7, 0.7, 0.7)}):Play()
        end
        cn.Visible = true
        game:GetService("TweenService"):Create(tb, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50), TextColor3 = Color3.new(1, 1, 1)}):Play()
    end)

    local tab = {}
    function tab:CreateCategory(n)
        local cf = Instance.new("Frame", cn)
        cf.Size, cf.AutomaticSize, cf.BackgroundTransparency = UDim2.new(1, -10, 0, 32), Enum.AutomaticSize.Y, 1
        local cl = Instance.new("UIListLayout", cf)
        cl.Padding = UDim.new(0, 5)

        local fb = Instance.new("TextButton", cf)
        fb.Size, fb.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(35, 35, 35)
        fb.Text, fb.TextColor3 = "v " .. n .. " v", Color3.new(1, 1, 1)
        Instance.new("UICorner", fb)

        local f = Instance.new("Frame", cf)
        f.Size, f.AutomaticSize, f.BackgroundTransparency = UDim2.new(1, 0, 0, 0), Enum.AutomaticSize.Y, 1
        f.Visible = false
        Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)

        fb.MouseButton1Click:Connect(function()
            f.Visible = not f.Visible
            fb.Text = (f.Visible and "^ " or "v ") .. n .. (f.Visible and " ^" or " v")
        end)

        local cat = {}
        function cat:AddToggle(txt, cb)
            local b = Instance.new("TextButton", f)
            b.Size, b.Text = UDim2.new(1, 0, 0, 30), txt
            b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(40, 40, 40), Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            local a = false
            b.MouseButton1Click:Connect(function()
                a = not a
                game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = a and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
                task.spawn(function() while a do pcall(cb) task.wait(0.3) end end)
            end)
        end
        return cat
    end
    return tab
end

return FexawLib
