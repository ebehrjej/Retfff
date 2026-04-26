Fexaw = {}

function Fexaw:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3_Core"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520
    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint, main.BackgroundColor3 = Vector2.new(0.5, 0.5), Color3.fromRGB(15, 15, 15)
    main.Visible, main.ClipsDescendants = false, true 
    Instance.new("UICorner", main)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness, mainStroke.ApplyStrokeMode = 3, Enum.ApplyStrokeMode.Border

    local side = Instance.new("Frame", main)
    side.Size, side.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)
    local sideLayout = Instance.new("UIListLayout", side)
    sideLayout.Padding, sideLayout.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center
    Instance.new("UIPadding", side).PaddingTop = UDim.new(0, 10)

    local sideStroke = Instance.new("UIStroke", side)
    sideStroke.Thickness, sideStroke.ApplyStrokeMode = 2, Enum.ApplyStrokeMode.Border

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local obStroke = Instance.new("UIStroke", ob)
    obStroke.Thickness, obStroke.ApplyStrokeMode = 2, Enum.ApplyStrokeMode.Border

    task.spawn(function()
        local hue = 0
        while true do
            local color = Color3.fromHSV(hue, 1, 1)
            mainStroke.Color, sideStroke.Color, obStroke.Color = color, color, color
            hue = hue + 0.005 task.wait(0.01)
        end
    end)

    local dragBtn = Instance.new("TextButton", ob)
    dragBtn.Size, dragBtn.BackgroundTransparency, dragBtn.Text = UDim2.new(0, 60, 1, 0), 1, "÷  |"
    dragBtn.TextColor3, dragBtn.TextSize, dragBtn.Font = Color3.new(1, 1, 1), 22, Enum.Font.SourceSansBold

    local openBtn = Instance.new("TextButton", ob)
    openBtn.Size, openBtn.Position = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0)
    openBtn.BackgroundTransparency, openBtn.Text = 1, "FEXAW | All Systems Online"
    openBtn.TextColor3, openBtn.TextXAlignment = Color3.new(1, 1, 1), Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, startPosMain
    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position
            startPos, startPosMain = ob.Position, main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            main.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
        end
    end)

    openBtn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play() tw.Completed:Connect(function() if main.Size.Y.Offset < 10 then main.Visible = false end end)
        end
    end)

    local allTabs = {}
    function Fexaw:CreateTab(name)
        local tabBtn = Instance.new("TextButton", side)
        tabBtn.Size, tabBtn.BackgroundColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30)
        tabBtn.Text, tabBtn.TextColor3 = name, Color3.new(0.7, 0.7, 0.7)
        Instance.new("UICorner", tabBtn)

        local container = Instance.new("ScrollingFrame", main)
        container.Position, container.Size = UDim2.new(0, 160, 0, 10), UDim2.new(1, -170, 1, -20)
        container.BackgroundTransparency, container.Visible = 1, false
        container.ScrollBarThickness, container.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
        Instance.new("UIListLayout", container).Padding = UDim.new(0, 5)
        
        table.insert(allTabs, {Btn = tabBtn, Cont = container})

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(allTabs) do
                t.Cont.Visible = false
                t.Btn.BackgroundColor3, t.Btn.TextColor3 = Color3.fromRGB(30, 30, 30), Color3.new(0.7, 0.7, 0.7)
            end
            container.Visible = true
            tabBtn.BackgroundColor3, tabBtn.TextColor3 = Color3.fromRGB(50, 50, 50), Color3.new(1, 1, 1)
        end)

        local tabFuncs = {}
        function tabFuncs:CreateCategory(catName)
            local f = Instance.new("Frame", container) f.Size, f.BackgroundTransparency = UDim2.new(1, -10, 0, 35), 1
            local btn = Instance.new("TextButton", f) btn.Size, btn.BackgroundColor3, btn.Text = UDim2.new(1, 0, 0, 30), Color3.fromRGB(30, 30, 30), "v " .. catName .. " v"
            btn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", btn)
            local cont = Instance.new("Frame", container) cont.Size, cont.AutomaticSize, cont.BackgroundTransparency, cont.Visible = UDim2.new(1, -10, 0, 0), Enum.AutomaticSize.Y, 1, false
            Instance.new("UIListLayout", cont).Padding = UDim.new(0, 5)
            btn.MouseButton1Click:Connect(function() cont.Visible = not cont.Visible btn.Text = (cont.Visible and "^ " or "v ") .. catName .. (cont.Visible and " ^" or " v") end)
            
            local catFuncs = {}
            function catFuncs:AddToggle(toggleName, callback)
                local active = false
                local b = Instance.new("TextButton", cont) b.Size, b.BackgroundColor3, b.Text = UDim2.new(1, 0, 0, 32), Color3.fromRGB(40, 40, 40), toggleName
                b.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(function()
                    active = not active
                    TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(40, 40, 40)}):Play()
                    task.spawn(function() while active do pcall(callback) task.wait(0.3) end end)
                end)
            end
            return catFuncs
        end
        return tabFuncs
    end
    return self
end
return Fexaw

