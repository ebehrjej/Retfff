FexawLib = {
    SaveData = {},
    Toggles = {},
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

for i = 1, 120 do
    FexawLib.Themes["Shade_" .. i] = Color3.fromHSV(i / 120, 0.7, 1)
end

function FexawLib:SaveConfig()
    local HttpService = game:GetService("HttpService")
    local success, json = pcall(function() return HttpService:JSONEncode(self.SaveData) end)
    if success then writefile("FexawConfig.json", json) end
end

function FexawLib:SetTheme(themeName)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    if self.RainbowLoop then self.RainbowLoop:Disconnect() self.RainbowLoop = nil end
    if themeName == "Rainbow" then
        self.RainbowLoop = RunService.RenderStepped:Connect(function()
            local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            self.MainStroke.Color = color
            self.ToggleStroke.Color = color
        end)
    elseif self.Themes[themeName] then
        local color = self.Themes[themeName]
        TweenService:Create(self.MainStroke, TweenInfo.new(0.5), {Color = color}):Play()
        TweenService:Create(self.ToggleStroke, TweenInfo.new(0.5), {Color = color}):Play()
    end
end

function FexawLib:Init()
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "FexawV4_Ultimate"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = false
    MainFrame.ClipsDescendants = true 
    Instance.new("UICorner", MainFrame)

    self.MainStroke = Instance.new("UIStroke", MainFrame)
    self.MainStroke.Thickness = 3
    self.MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local DragLeft = Instance.new("Frame", MainFrame)
    DragLeft.Size = UDim2.new(0, 7, 1, 0)
    DragLeft.BackgroundColor3 = Color3.new(1, 1, 1)
    DragLeft.BackgroundTransparency = 0.9
    Instance.new("UICorner", DragLeft)

    local DragRight = Instance.new("Frame", MainFrame)
    DragRight.Size = UDim2.new(0, 7, 1, 0)
    DragRight.Position = UDim2.new(1, -7, 0, 0)
    DragRight.BackgroundColor3 = Color3.new(1, 1, 1)
    DragRight.BackgroundTransparency = 0.9
    Instance.new("UICorner", DragRight)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, -160, 0, 35)
    TopBar.Position = UDim2.new(0, 160, 0, 0)
    TopBar.BackgroundTransparency = 1

    local SearchBtn = Instance.new("TextButton", TopBar)
    SearchBtn.Size = UDim2.new(0, 30, 0, 30)
    SearchBtn.Position = UDim2.new(1, -110, 0, 5)
    SearchBtn.Text, SearchBtn.TextColor3, SearchBtn.BackgroundTransparency = "🔍", Color3.new(1, 1, 1), 1

    local MinusBtn = Instance.new("TextButton", TopBar)
    MinusBtn.Size = UDim2.new(0, 30, 0, 30)
    MinusBtn.Position = UDim2.new(1, -75, 0, 5)
    MinusBtn.Text, MinusBtn.TextColor3, MinusBtn.BackgroundTransparency = "-", Color3.new(1, 1, 1), 1
    MinusBtn.TextSize = 25

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0, 5)
    CloseBtn.Text, CloseBtn.TextColor3, CloseBtn.BackgroundTransparency = "X", Color3.fromRGB(255, 50, 50), 1

    local SearchFrame = Instance.new("Frame", MainFrame)
    SearchFrame.Size, SearchFrame.Position = UDim2.new(0, 0, 0, 30), UDim2.new(0, 170, 0, 40)
    SearchFrame.BackgroundColor3, SearchFrame.Visible, SearchFrame.ClipsDescendants = Color3.fromRGB(25, 25, 25), false, true
    Instance.new("UICorner", SearchFrame)
    local SearchInput = Instance.new("TextBox", SearchFrame)
    SearchInput.Size, SearchInput.BackgroundTransparency = UDim2.new(1, -10, 1, 0), 1
    SearchInput.Position = UDim2.new(0, 5, 0, 0)
    SearchInput.PlaceholderText, SearchInput.TextColor3, SearchInput.Text = "Search...", Color3.new(1, 1, 1), ""

    local Confirm = Instance.new("Frame", ScreenGui)
    Confirm.Size, Confirm.Position = UDim2.new(0, 300, 0, 120), UDim2.new(0.5, -150, 0.5, -60)
    Confirm.BackgroundColor3, Confirm.Visible = Color3.fromRGB(30, 30, 30), false
    Instance.new("UICorner", Confirm)
    Instance.new("UIStroke", Confirm).Thickness = 2
    local confTxt = Instance.new("TextLabel", Confirm)
    confTxt.Size, confTxt.Text = UDim2.new(1, 0, 0, 60), "Are you sure you want to close the menu?"
    confTxt.TextColor3, confTxt.BackgroundTransparency = Color3.new(1, 1, 1), 1
    local Yes = Instance.new("TextButton", Confirm)
    Yes.Size, Yes.Position, Yes.Text, Yes.BackgroundColor3 = UDim2.new(0, 100, 0, 35), UDim2.new(0.1, 0, 0.6, 0), "Yes", Color3.fromRGB(0, 150, 0)
    Instance.new("UICorner", Yes)
    local No = Instance.new("TextButton", Confirm)
    No.Size, No.Position, No.Text, No.BackgroundColor3 = UDim2.new(0, 100, 0, 35), UDim2.new(0.55, 0, 0.6, 0), "No", Color3.fromRGB(150, 0, 0)
    Instance.new("UICorner", No)

    local ob = Instance.new("Frame", ScreenGui)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    self.ToggleStroke = Instance.new("UIStroke", ob)
    self.ToggleStroke.Thickness = 2

    local db = Instance.new("TextButton", ob)
    db.Size, db.BackgroundTransparency, db.Text = UDim2.new(0, 60, 1, 0), 1, "÷  |"
    db.TextColor3, db.TextSize = Color3.new(1, 1, 1), 22
    local obn = Instance.new("TextButton", ob)
    obn.Size, obn.Position = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0)
    obn.BackgroundTransparency, obn.Text = 1, "FEXAW | MENU"
    obn.TextColor3, obn.TextXAlignment = Color3.new(1, 1, 1), Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, mStartPos
    local function initDrag(gui, target)
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging, dragStart, startPos, mStartPos = true, input.Position, target.Position, MainFrame.Position
                input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
            end
        end)
    end
    initDrag(DragLeft, MainFrame) initDrag(DragRight, MainFrame) initDrag(db, ob)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            MainFrame.Position = UDim2.new(mStartPos.X.Scale, mStartPos.X.Offset + delta.X, mStartPos.Y.Scale, mStartPos.Y.Offset + delta.Y)
        end
    end)

    local function toggle()
        if not MainFrame.Visible then
            MainFrame.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 520, 0, 380)}):Play()
        else
            local tw = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play() tw.Completed:Connect(function() if MainFrame.Size.X.Offset < 10 then MainFrame.Visible = false end end)
        end
    end

    obn.MouseButton1Click:Connect(toggle)
    MinusBtn.MouseButton1Click:Connect(toggle)
    CloseBtn.MouseButton1Click:Connect(function() Confirm.Visible = true end)
    No.MouseButton1Click:Connect(function() Confirm.Visible = false end)
    Yes.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    SearchBtn.MouseButton1Click:Connect(function()
        SearchFrame.Visible = not SearchFrame.Visible
        TweenService:Create(SearchFrame, TweenInfo.new(0.3), {Size = SearchFrame.Visible and UDim2.new(1, -180, 0, 30) or UDim2.new(0, 0, 0, 30)}):Play()
    end)

    SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
        local t = SearchInput.Text:lower()
        for _, tab in pairs(self.Tabs) do
            for _, obj in pairs(tab.Cont:GetChildren()) do
                if obj:IsA("Frame") or obj:IsA("TextButton") then
                    obj.Visible = t == "" or (obj:IsA("TextButton") and obj.Text:lower():find(t)) or (obj:FindFirstChild("TextButton") and obj.TextButton.Text:lower():find(t))
                end
            end
        end
    end)

    self.MainFrame = MainFrame
    self.SideBar = Instance.new("Frame", MainFrame)
    self.SideBar.Size, self.SideBar.BackgroundColor3 = UDim2.new(0, 150, 1, 0), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", self.SideBar)
    local sl = Instance.new("UIListLayout", self.SideBar)
    sl.Padding, sl.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center

    self:SetTheme("Neon")
    return self
end

function FexawLib:CreateTab(name)
    local tb = Instance.new("TextButton", self.SideBar)
    tb.Size, tb.BackgroundColor3, tb.Text, tb.TextColor3 = UDim2.new(0.9, 0, 0, 32), Color3.fromRGB(30, 30, 30), name, Color3.new(0.7, 0.7, 0.7)
    Instance.new("UICorner", tb)

    local cn = Instance.new("ScrollingFrame", self.MainFrame)
    cn.Position, cn.Size = UDim2.new(0, 160, 0, 45), UDim2.new(1, -170, 1, -55)
    cn.BackgroundTransparency, cn.Visible = 1, false
    cn.ScrollBarThickness, cn.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", cn).Padding = UDim.new(0, 5)

    table.insert(self.Tabs, {Btn = tb, Cont = cn})
    tb.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do t.Cont.Visible = false end
        cn.Visible = true
    end)

    local tabObj = {}

    function tabObj:AddToggle(txt, callback)
        local b = Instance.new("TextButton", cn)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(40, 40, 40), txt, Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        local active = false
        b.MouseButton1Click:Connect(function()
            active = not active
            FexawLib.Toggles[txt] = active
            game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
            if active then task.spawn(function() while FexawLib.Toggles[txt] do pcall(callback) task.wait(0.3) end end) end
        end)
    end

    function tabObj:AddSlider(txt, min, max, default, callback)
        local f = Instance.new("Frame", cn)
        f.Size, f.BackgroundColor3 = UDim2.new(1, -10, 0, 45), Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f)
        l.Size, l.Position, l.Text = UDim2.new(1, 0, 0, 20), UDim2.new(0, 5, 0, 0), txt .. ": " .. default
        l.BackgroundTransparency, l.TextColor3, l.TextXAlignment = 1, Color3.new(1, 1, 1), Enum.TextXAlignment.Left
        local bar = Instance.new("Frame", f)
        bar.Size, bar.Position, bar.BackgroundColor3 = UDim2.new(0.9, 0, 0, 5), UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(50, 50, 50)
        local fill = Instance.new("Frame", bar)
        fill.Size, fill.BackgroundColor3 = UDim2.new((default - min) / (max - min), 0, 1, 0), Color3.fromRGB(0, 200, 255)
        local drag = false
        local function update()
            local mousePos = game:GetService("UserInputService"):GetMouseLocation().X
            local percent = math.clamp((mousePos - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * percent)
            fill.Size, l.Text = UDim2.new(percent, 0, 1, 0), txt .. ": " .. val
            pcall(callback, val)
        end
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end end)
        game:GetService("UserInputService").InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        game:GetService("UserInputService").InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
    end

    function tabObj:AddDropdown(txt, list, callback)
        local f = Instance.new("Frame", cn)
        f.Size, f.BackgroundColor3, f.AutomaticSize = UDim2.new(1, -10, 0, 30), Color3.fromRGB(35, 35, 35), Enum.AutomaticSize.Y
        Instance.new("UICorner", f)
        local btn = Instance.new("TextButton", f)
        btn.Size, btn.Text, btn.BackgroundColor3, btn.TextColor3 = UDim2.new(1, 0, 0, 30), txt .. " ▼", Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
        Instance.new("UICorner", btn)
        local c = Instance.new("Frame", f)
        c.Size, c.Position, c.Visible, c.BackgroundTransparency = UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 0, 30), false, 1
        c.AutomaticSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", c)
        btn.MouseButton1Click:Connect(function() c.Visible = not c.Visible end)
        for _, v in pairs(list) do
            local ib = Instance.new("TextButton", c)
            ib.Size, ib.Text, ib.BackgroundColor3, ib.TextColor3 = UDim2.new(1, 0, 0, 25), v, Color3.fromRGB(55, 55, 55), Color3.new(0.8, 0.8, 0.8)
            ib.MouseButton1Click:Connect(function() btn.Text, c.Visible = v .. " ▼", false pcall(callback, v) end)
        end
    end

    function tabObj:AddTextBox(txt, callback)
        local f = Instance.new("Frame", cn)
        f.Size, f.BackgroundColor3 = UDim2.new(1, -10, 0, 35), Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f)
        l.Size, l.Position, l.Text, l.BackgroundTransparency = UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 5, 0, 0), txt, 1
        l.TextColor3, l.TextXAlignment = Color3.new(1, 1, 1), Enum.TextXAlignment.Left
        local box = Instance.new("TextBox", f)
        box.Size, box.Position = UDim2.new(0.5, 0, 0.8, 0), UDim2.new(0.45, 0, 0.1, 0)
        box.BackgroundColor3, box.TextColor3, box.Text = Color3.fromRGB(25, 25, 25), Color3.new(1, 1, 1), ""
        Instance.new("UICorner", box)
        box.FocusLost:Connect(function(e) if e then pcall(callback, box.Text) end end)
    end

    function tabObj:CreateCategory(cN)
        local cf = Instance.new("Frame", cn)
        cf.Size, cf.AutomaticSize, cf.BackgroundTransparency = UDim2.new(1, -10, 0, 32), Enum.AutomaticSize.Y, 1
        Instance.new("UIListLayout", cf).Padding = UDim.new(0, 5)
        local fb = Instance.new("TextButton", cf)
        fb.Size, fb.BackgroundColor3, fb.Text, fb.TextColor3, fb.LayoutOrder = UDim2.new(1, 0, 0, 30), Color3.fromRGB(35, 35, 35), "v " .. cN .. " v", Color3.new(1, 1, 1), -1
        Instance.new("UICorner", fb)
        local f = Instance.new("Frame", cf)
        f.Size, f.AutomaticSize, f.BackgroundTransparency, f.Visible, f.LayoutOrder = UDim2.new(1, 0, 0, 0), Enum.AutomaticSize.Y, 1, false, 1
        Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
        fb.MouseButton1Click:Connect(function() f.Visible = not f.Visible fb.Text = (f.Visible and "^ " or "v ") .. cN .. (f.Visible and " ^" or " v") end)
        local cat = {}
        function cat:AddToggle(t, c)
            local b = Instance.new("TextButton", f)
            b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(40, 40, 40), t, Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            local a = false
            b.MouseButton1Click:Connect(function()
                a = not a
                FexawLib.Toggles[t] = a
                game:GetService("TweenService"):Create(b, TweenInfo.new(0.3), {BackgroundColor3 = a and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)}):Play()
                if a then task.spawn(function() while FexawLib.Toggles[t] do pcall(c) task.wait(0.3) end end) end
            end)
        end
        function cat:AddButton(t, c)
            local b = Instance.new("TextButton", f)
            b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(45, 45, 45), t, Color3.new(1, 1, 1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() pcall(c) end)
        end
        return cat
    end

    function tabObj:AddButton(txt, cb)
        local b = Instance.new("TextButton", cn)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(45, 45, 45), txt, Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(cb)
    end

    return tabObj
end

return FexawLib
