local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local p = game.Players.LocalPlayer

local Library = {}

function Library:CreateWindow(hubName)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3_Library"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520
    
    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.1, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.1
    ob.ZIndex = 10
    Instance.new("UICorner", ob)
    local obStroke = Instance.new("UIStroke", ob)
    obStroke.Thickness, obStroke.Color = 2, Color3.new(1,1,1)

    local main = Instance.new("Frame", sg)
    main.Size, main.Position = UDim2.new(0, targetWidth, 0, 0), UDim2.new(0.5, -targetWidth/2, 0.1, 45)
    main.BackgroundColor3, main.Visible, main.ClipsDescendants = Color3.fromRGB(15, 15, 15), false, true
    Instance.new("UICorner", main)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness, mainStroke.ApplyStrokeMode = 3, Enum.ApplyStrokeMode.Border

    local side = Instance.new("Frame", main)
    side.Size, side.BackgroundColor3 = UDim2.new(0, 140, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)

    local tabContainer = Instance.new("ScrollingFrame", side)
    tabContainer.Size, tabContainer.Position = UDim2.new(1, -10, 1, -20), UDim2.new(0, 5, 0, 10)
    tabContainer.BackgroundTransparency, tabContainer.ScrollBarThickness = 0, 0
    Instance.new("UIListLayout", tabContainer).Padding = UDim.new(0, 5)

    local contentHolder = Instance.new("Frame", main)
    contentHolder.Size, contentHolder.Position = UDim2.new(1, -150, 1, -20), UDim2.new(0, 145, 0, 10)
    contentHolder.BackgroundTransparency = 1

    task.spawn(function()
        local h = 0
        while true do
            local c = Color3.fromHSV(h, 1, 1)
            mainStroke.Color, obStroke.Color = c, c
            h = h + 0.005 if h > 1 then h = 0 end
            task.wait(0.01)
        end
    end)

    local dragBtn = Instance.new("TextButton", ob)
    dragBtn.Size, dragBtn.BackgroundTransparency, dragBtn.Text = UDim2.new(0, 50, 1, 0), 1, "≡"
    dragBtn.TextColor3, dragBtn.TextSize = Color3.new(1, 1, 1), 25

    local openBtn = Instance.new("TextButton", ob)
    openBtn.Size, openBtn.Position, openBtn.BackgroundTransparency = UDim2.new(1, -60, 1, 0), UDim2.new(0, 60, 0, 0), 1
    openBtn.Text, openBtn.TextColor3, openBtn.TextXAlignment = hubName, Color3.new(1, 1, 1), Enum.TextXAlignment.Left

    local isOpen = false
    openBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, targetWidth, 0, 0)})
            tw:Play()
            tw.Completed:Connect(function() if not isOpen then main.Visible = false end end)
        end
    end)

    local dragging, dragStart, startPos, startPosMain
    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos, startPosMain = true, input.Position, ob.Position, main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            main.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + d.X, startPosMain.Y.Scale, startPosMain.Y.Offset + d.Y)
        end
    end)

    local tabs = {}
    local windowFunctions = {}

    function windowFunctions:CreateTab(name)
        local tBtn = Instance.new("TextButton", tabContainer)
        tBtn.Size, tBtn.BackgroundColor3, tBtn.Text = UDim2.new(1, 0, 0, 30), Color3.fromRGB(30, 30, 30), name
        tBtn.TextColor3, tBtn.TextSize = Color3.new(0.7, 0.7, 0.7), 14
        Instance.new("UICorner", tBtn)
        
        local page = Instance.new("ScrollingFrame", contentHolder)
        page.Size, page.Visible, page.BackgroundTransparency = UDim2.new(1, 0, 1, 0), false, 1
        page.ScrollBarThickness, page.AutomaticCanvasSize = 0, Enum.AutomaticSize.Y
        Instance.new("UIListLayout", page).Padding = UDim.new(0, 5)
        
        tBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(tabs) do
                v.Page.Visible = false
                v.Btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                v.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            page.Visible = true
            tBtn.TextColor3 = Color3.new(1, 1, 1)
            tBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
        
        tabs[name] = {Btn = tBtn, Page = page}
        if #tabContainer:GetChildren() == 2 then page.Visible = true tBtn.TextColor3 = Color3.new(1, 1, 1) end

        local tabFunctions = {}

        function tabFunctions:AddButton(text, callback)
            local b = Instance.new("TextButton", page)
            b.Size, b.BackgroundColor3, b.Text = UDim2.new(1, -5, 0, 32), Color3.fromRGB(35, 35, 35), text
            b.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function tabFunctions:AddToggle(text, callback)
            local state = false
            local b = Instance.new("TextButton", page)
            b.Size, b.BackgroundColor3, b.Text = UDim2.new(1, -5, 0, 32), Color3.fromRGB(35, 35, 35), text .. " : OFF"
            b.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function()
                state = not state
                b.Text = text .. (state and " : ON" or " : OFF")
                b.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(35, 35, 35)
                pcall(callback, state)
            end)
        end

        return tabFunctions
    end
    return windowFunctions
end

-- ПРИМЕР ИСПОЛЬЗОВАНИЯ:
local Window = Library:CreateWindow("FEXAW V3")

local MainTab = Window:CreateTab("Main")
MainTab:AddButton("Destroy GUI", function()
    p.PlayerGui.FexawV3_Library:Destroy()
end)

MainTab:AddToggle("Infinite Jump", function(s)
    print("State:", s)
end)

local Visuals = Window:CreateTab("Visuals")
Visuals:AddButton("Coming Soon...", function() end)
