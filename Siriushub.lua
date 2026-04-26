FexawLib = {}

function FexawLib:Init()
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game.Players.LocalPlayer
    
    local sg = Instance.new("ScreenGui")
    sg.Parent = p.PlayerGui
    sg.Name = "FexawV3"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Parent = sg
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = false
    main.ClipsDescendants = true 
    Instance.new("UICorner", main)
    
    local ms = Instance.new("UIStroke", main)
    ms.Thickness = 3
    ms.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local dragL = Instance.new("Frame")
    dragL.Parent = main
    dragL.Name = "DragLeft"
    dragL.Size = UDim2.new(0, 7, 1, 0)
    dragL.Position = UDim2.new(0, 0, 0, 0)
    dragL.BackgroundColor3 = Color3.new(1, 1, 1)
    dragL.BackgroundTransparency = 0.9
    Instance.new("UICorner", dragL)

    local dragR = Instance.new("Frame")
    dragR.Parent = main
    dragR.Name = "DragRight"
    dragR.Size = UDim2.new(0, 7, 1, 0)
    dragR.Position = UDim2.new(1, -7, 0, 0)
    dragR.BackgroundColor3 = Color3.new(1, 1, 1)
    dragR.BackgroundTransparency = 0.9
    Instance.new("UICorner", dragR)

    local side = Instance.new("Frame")
    side.Parent = main
    side.Name = "SideBar"
    side.Size = UDim2.new(0, 150, 1, 0)
    side.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)
    
    local sl = Instance.new("UIListLayout", side)
    sl.Padding = UDim.new(0, 5)
    sl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local ss = Instance.new("UIStroke", side)
    ss.Thickness = 2
    ss.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local ob = Instance.new("Frame")
    ob.Parent = sg
    ob.Name = "ToggleFrame"
    ob.Size = UDim2.new(0, 350, 0, 40)
    ob.Position = UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ob.BackgroundTransparency = 0.2
    Instance.new("UICorner", ob)
    
    local os = Instance.new("UIStroke", ob)
    os.Thickness = 2

    local themes = {
        Neon = Color3.fromRGB(0, 255, 255), 
        Fire = Color3.fromRGB(255, 50, 0), 
        Water = Color3.fromRGB(0, 100, 255),
        Blue = Color3.fromRGB(50, 150, 255), 
        Dark = Color3.fromRGB(30, 30, 30), 
        Light = Color3.fromRGB(200, 200, 200),
        White = Color3.fromRGB(255, 255, 255), 
        Orange = Color3.fromRGB(255, 150, 0), 
        Candy = Color3.fromRGB(255, 100, 200)
    }

    local rbLoop = nil
    function self:SetTheme(name)
        if rbLoop then rbLoop:Disconnect() rbLoop = nil end
        if name:lower() == "rainbow" then
            rbLoop = game:GetService("RunService").RenderStepped:Connect(function()
                local c = Color3.fromHSV(tick()%5/5, 1, 1)
                ms.Color = c
                ss.Color = c
                os.Color = c
            end)
        elseif themes[name] then
            local c = themes[name]
            TS:Create(ms, TweenInfo.new(0.5), {Color = c}):Play()
            TS:Create(ss, TweenInfo.new(0.5), {Color = c}):Play()
            TS:Create(os, TweenInfo.new(0.5), {Color = c}):Play()
        end
    end

    local db = Instance.new("TextButton")
    db.Parent = ob
    db.Size = UDim2.new(0, 60, 1, 0)
    db.BackgroundTransparency = 1
    db.Text = "÷  |"
    db.TextColor3 = Color3.new(1, 1, 1)
    db.TextSize = 22
    
    local obn = Instance.new("TextButton")
    obn.Parent = ob
    obn.Size = UDim2.new(1, -65, 1, 0)
    obn.Position = UDim2.new(0, 65, 0, 0)
    obn.BackgroundTransparency = 1
    obn.Text = "FEXAW | MENU"
    obn.TextColor3 = Color3.new(1, 1, 1)
    obn.TextXAlignment = Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, mainStartPos
    local function update(input)
        local delta = input.Position - dragStart
        ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        main.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + delta.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + delta.Y)
    end
    
    local function initDrag(gui)
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = ob.Position
                mainStartPos = main.Position
                input.Changed:Connect(function() 
                    if input.UserInputState == Enum.UserInputState.End then 
                        dragging = false 
                    end 
                end)
            end
        end)
    end
    
    initDrag(dragL) 
    initDrag(dragR) 
    initDrag(db)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then 
            update(input) 
        end
    end)

    obn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 380)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play()
            tw.Completed:Connect(function() 
                if main.Size.X.Offset < 10 then 
                    main.Visible = false 
                end 
            end)
        end
    end)

    self.allTabs = {}
    self.mainFrame = main
    self.sideBar = side
    
    local st = self:CreateTab("Settings")
    st:AddTextBox("Theme", function(v) self:SetTheme(v) end)
    self:SetTheme("Neon")
    
    return self
end

function FexawLib:CreateTab(name)
    local tb = Instance.new("TextButton")
    tb.Parent = side
    tb.Size = UDim2.new(0.9, 0, 0, 32)
    tb.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tb.Text = name
    tb.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", tb)

    local cn = Instance.new("ScrollingFrame")
    cn.Parent = main
    cn.Position = UDim2.new(0, 160, 0, 10)
    cn.Size = UDim2.new(1, -170, 1, -20)
    cn.BackgroundTransparency = 1
    cn.Visible = false
    cn.ScrollBarThickness = 2
    cn.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local cl = Instance.new("UIListLayout", cn)
    cl.Padding = UDim.new(0, 5)
    cl.SortOrder = Enum.SortOrder.LayoutOrder

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
    
    function tab:AddTextBox(txt, cb)
        local f = Instance.new("Frame")
        f.Parent = cn
        f.Size = UDim2.new(1, -10, 0, 35)
        f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f)
        
        local l = Instance.new("TextLabel")
        l.Parent = f
        l.Size = UDim2.new(0.4, 0, 1, 0)
        l.Position = UDim2.new(0, 5, 0, 0)
        l.BackgroundTransparency = 1
        l.Text = txt
        l.TextColor3 = Color3.new(1, 1, 1)
        l.TextXAlignment = Enum.TextXAlignment.Left
        
        local box = Instance.new("TextBox")
        box.Parent = f
        box.Size = UDim2.new(0.5, 0, 0.8, 0)
        box.Position = UDim2.new(0.45, 0, 0.1, 0)
        box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        box.Text = ""
        box.TextColor3 = Color3.new(1, 1, 1)
        box.PlaceholderText = "..."
        Instance.new("UICorner", box)
        
        box.FocusLost:Connect(function(e) 
            if e then 
                pcall(cb, box.Text) 
            end 
        end)
    end

    function tab:CreateCategory(n)
        local cf = Instance.new("Frame")
        cf.Parent = cn
        cf.Size = UDim2.new(1, -10, 0, 32)
        cf.AutomaticSize = Enum.AutomaticSize.Y
        cf.BackgroundTransparency = 1
        
        local cl_cf = Instance.new("UIListLayout", cf)
        cl_cf.Padding = UDim.new(0, 5)
        cl_cf.SortOrder = Enum.SortOrder.LayoutOrder
        
        local fb = Instance.new("TextButton")
        fb.Parent = cf
        fb.Size = UDim2.new(1, 0, 0, 30)
        fb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        fb.LayoutOrder = -1
        fb.Text = "v " .. n .. " v"
        fb.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", fb)
        
        local f_cat = Instance.new("Frame")
        f_cat.Parent = cf
        f_cat.Size = UDim2.new(1, 0, 0, 0)
        f_cat.AutomaticSize = Enum.AutomaticSize.Y
        f_cat.BackgroundTransparency = 1
        f_cat.LayoutOrder = 1
        f_cat.Visible = false
        Instance.new("UIListLayout", f_cat).Padding = UDim.new(0, 5)
        
        fb.MouseButton1Click:Connect(function()
            f_cat.Visible = not f_cat.Visible
            fb.Text = (f_cat.Visible and "^ " or "v ") .. n .. (f_cat.Visible and " ^" or " v")
        end)
        
        local cat = {}
        function cat:AddToggle(txt, cb)
            local b = Instance.new("TextButton")
            b.Parent = f_cat
            b.Size = UDim2.new(1, 0, 0, 30)
            b.Text = txt
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            b.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            
            local a = false
            b.MouseButton1Click:Connect(function()
                a = not a
                game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = a and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
                task.spawn(function() 
                    while a do 
                        pcall(cb) 
                        task.wait(0.3) 
                    end 
                end)
            end)
        end
        return cat
    end
    return tab
end

return FexawLib
