_G.FexawThemes = {
    ["Neon"] = {
        MainColor = Color3.fromRGB(20, 0, 20),
        SideColor = Color3.fromRGB(30, 0, 30),
        TopColor = Color3.fromRGB(40, 0, 40),
        StrokeColor = Color3.fromRGB(255, 0, 255),
        Rainbow = false
    },
    ["Fire"] = {
        MainColor = Color3.fromRGB(30, 5, 0),
        SideColor = Color3.fromRGB(50, 10, 0),
        TopColor = Color3.fromRGB(70, 20, 0),
        StrokeColor = Color3.fromRGB(255, 100, 0),
        Rainbow = false
    },
    ["Toxic"] = {
        MainColor = Color3.fromRGB(5, 20, 5),
        SideColor = Color3.fromRGB(10, 30, 10),
        TopColor = Color3.fromRGB(15, 50, 15),
        StrokeColor = Color3.fromRGB(0, 255, 0),
        Rainbow = false
    },
    ["Blue"] = {
        MainColor = Color3.fromRGB(5, 10, 30),
        SideColor = Color3.fromRGB(10, 20, 50),
        TopColor = Color3.fromRGB(15, 30, 70),
        StrokeColor = Color3.fromRGB(0, 150, 255),
        Rainbow = false
    },
    ["Rainbow"] = {
        MainColor = Color3.fromRGB(15, 15, 15),
        SideColor = Color3.fromRGB(20, 20, 20),
        TopColor = Color3.fromRGB(25, 25, 25),
        StrokeColor = Color3.fromRGB(255, 255, 255),
        Rainbow = true
    },
    ["Gray"] = {
        MainColor = Color3.fromRGB(40, 40, 40),
        SideColor = Color3.fromRGB(30, 30, 30),
        TopColor = Color3.fromRGB(50, 50, 50),
        StrokeColor = Color3.fromRGB(150, 150, 150),
        Rainbow = false
    },
    ["Black"] = {
        MainColor = Color3.fromRGB(5, 5, 5),
        SideColor = Color3.fromRGB(0, 0, 0),
        TopColor = Color3.fromRGB(10, 10, 10),
        StrokeColor = Color3.fromRGB(50, 50, 50),
        Rainbow = false
    },
    ["Light"] = {
        MainColor = Color3.fromRGB(240, 240, 240),
        SideColor = Color3.fromRGB(220, 220, 220),
        TopColor = Color3.fromRGB(255, 255, 255),
        StrokeColor = Color3.fromRGB(100, 100, 100),
        Rainbow = false
    },
    ["Red"] = {
        MainColor = Color3.fromRGB(20, 0, 0),
        SideColor = Color3.fromRGB(40, 0, 0),
        TopColor = Color3.fromRGB(60, 0, 0),
        StrokeColor = Color3.fromRGB(255, 0, 0),
        Rainbow = false
    },
    ["Water"] = {
        MainColor = Color3.fromRGB(0, 20, 40),
        SideColor = Color3.fromRGB(0, 30, 60),
        TopColor = Color3.fromRGB(0, 40, 80),
        StrokeColor = Color3.fromRGB(0, 200, 255),
        Rainbow = false
    },
    ["Vampire"] = {
        MainColor = Color3.fromRGB(15, 0, 0),
        SideColor = Color3.fromRGB(10, 0, 0),
        TopColor = Color3.fromRGB(25, 0, 0),
        StrokeColor = Color3.fromRGB(150, 0, 0),
        Rainbow = false
    },
    ["Forest"] = {
        MainColor = Color3.fromRGB(10, 20, 10),
        SideColor = Color3.fromRGB(15, 30, 15),
        TopColor = Color3.fromRGB(20, 40, 20),
        StrokeColor = Color3.fromRGB(50, 150, 50),
        Rainbow = false
    },
    ["Gold"] = {
        MainColor = Color3.fromRGB(30, 25, 0),
        SideColor = Color3.fromRGB(45, 35, 0),
        TopColor = Color3.fromRGB(60, 50, 0),
        StrokeColor = Color3.fromRGB(255, 200, 0),
        Rainbow = false
    },
    ["Midnight"] = {
        MainColor = Color3.fromRGB(5, 5, 15),
        SideColor = Color3.fromRGB(10, 10, 25),
        TopColor = Color3.fromRGB(15, 15, 40),
        StrokeColor = Color3.fromRGB(100, 100, 255),
        Rainbow = false
    },
    ["Ghost"] = {
        MainColor = Color3.fromRGB(30, 30, 35),
        SideColor = Color3.fromRGB(25, 25, 30),
        TopColor = Color3.fromRGB(40, 40, 50),
        StrokeColor = Color3.fromRGB(200, 200, 220),
        Rainbow = false
    }
}

function _G.ApplyFexawTheme(ThemeName)
    local SelectedTheme = _G.FexawThemes[ThemeName]
    if SelectedTheme then
        _G.CurrentTheme = SelectedTheme
        if _G.UpdateMenuVisuals then
            _G.UpdateMenuVisuals()
        end
    end
end
