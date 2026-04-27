_G.FexawThemes = {
    ["Neon"] = {
        MainColor = Color3.fromRGB(20, 15, 30),
        SideColor = Color3.fromRGB(15, 10, 20),
        TopColor = Color3.fromRGB(30, 20, 45),
        AccentColor = Color3.fromRGB(255, 0, 255)
    },
    ["Toxic"] = {
        MainColor = Color3.fromRGB(10, 25, 15),
        SideColor = Color3.fromRGB(5, 15, 10),
        TopColor = Color3.fromRGB(15, 40, 20),
        AccentColor = Color3.fromRGB(0, 255, 100)
    },
    ["Fire"] = {
        MainColor = Color3.fromRGB(30, 10, 10),
        SideColor = Color3.fromRGB(20, 5, 5),
        TopColor = Color3.fromRGB(50, 15, 10),
        AccentColor = Color3.fromRGB(255, 60, 0)
    },
    ["DeepSea"] = {
        MainColor = Color3.fromRGB(10, 20, 35),
        SideColor = Color3.fromRGB(5, 15, 25),
        TopColor = Color3.fromRGB(15, 35, 60),
        AccentColor = Color3.fromRGB(0, 180, 255)
    },
    ["Vampire"] = {
        MainColor = Color3.fromRGB(15, 0, 0),
        SideColor = Color3.fromRGB(10, 0, 0),
        TopColor = Color3.fromRGB(30, 0, 0),
        AccentColor = Color3.fromRGB(255, 0, 0)
    },
    ["Gold"] = {
        MainColor = Color3.fromRGB(25, 20, 10),
        SideColor = Color3.fromRGB(15, 12, 5),
        TopColor = Color3.fromRGB(45, 35, 15),
        AccentColor = Color3.fromRGB(255, 200, 0)
    },
    ["Midnight"] = {
        MainColor = Color3.fromRGB(8, 8, 15),
        SideColor = Color3.fromRGB(5, 5, 10),
        TopColor = Color3.fromRGB(12, 12, 25),
        AccentColor = Color3.fromRGB(100, 100, 255)
    },
    ["Forest"] = {
        MainColor = Color3.fromRGB(15, 20, 15),
        SideColor = Color3.fromRGB(10, 15, 10),
        TopColor = Color3.fromRGB(20, 35, 20),
        AccentColor = Color3.fromRGB(80, 200, 80)
    },
    ["Obsidian"] = {
        MainColor = Color3.fromRGB(10, 10, 10),
        SideColor = Color3.fromRGB(5, 5, 5),
        TopColor = Color3.fromRGB(18, 18, 18),
        AccentColor = Color3.fromRGB(200, 200, 200)
    },
    ["Ghost"] = {
        MainColor = Color3.fromRGB(30, 30, 35),
        SideColor = Color3.fromRGB(25, 25, 30),
        TopColor = Color3.fromRGB(45, 45, 55),
        AccentColor = Color3.fromRGB(180, 180, 220)
    },
    ["Candy"] = {
        MainColor = Color3.fromRGB(40, 20, 35),
        SideColor = Color3.fromRGB(30, 10, 25),
        TopColor = Color3.fromRGB(60, 30, 50),
        AccentColor = Color3.fromRGB(255, 100, 200)
    },
    ["Mint"] = {
        MainColor = Color3.fromRGB(20, 35, 30),
        SideColor = Color3.fromRGB(15, 25, 20),
        TopColor = Color3.fromRGB(30, 50, 45),
        AccentColor = Color3.fromRGB(150, 255, 200)
    },
    ["Coffee"] = {
        MainColor = Color3.fromRGB(25, 20, 15),
        SideColor = Color3.fromRGB(15, 10, 8),
        TopColor = Color3.fromRGB(40, 30, 25),
        AccentColor = Color3.fromRGB(180, 140, 100)
    },
    ["Light"] = {
        MainColor = Color3.fromRGB(240, 240, 245),
        SideColor = Color3.fromRGB(220, 220, 230),
        TopColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(0, 120, 255)
    },
    ["Shadow"] = {
        MainColor = Color3.fromRGB(12, 12, 14),
        SideColor = Color3.fromRGB(7, 7, 9),
        TopColor = Color3.fromRGB(25, 25, 30),
        AccentColor = Color3.fromRGB(255, 255, 255)
    }
}

function _G.ApplyFexawTheme(ThemeName)
    local SelectedTheme = _G.FexawThemes[ThemeName]
    if SelectedTheme then
        _G.CurrentTheme.MainColor = SelectedTheme.MainColor
        _G.CurrentTheme.SideColor = SelectedTheme.SideColor
        _G.CurrentTheme.TopColor = SelectedTheme.TopColor
        _G.CurrentTheme.AccentColor = SelectedTheme.AccentColor
        if _G.UpdateMenuVisuals then
            _G.UpdateMenuVisuals()
        end
    end
end
