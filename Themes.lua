_G.FexawThemes = {
    ["Neon"] = {
        MainColor = Color3.fromRGB(40, 0, 40),
        SideColor = Color3.fromRGB(20, 0, 20),
        TopColor = Color3.fromRGB(60, 0, 60)
    },
    ["Toxic"] = {
        MainColor = Color3.fromRGB(0, 40, 0),
        SideColor = Color3.fromRGB(0, 20, 0),
        TopColor = Color3.fromRGB(0, 60, 0)
    },
    ["Fire"] = {
        MainColor = Color3.fromRGB(40, 10, 0),
        SideColor = Color3.fromRGB(20, 5, 0),
        TopColor = Color3.fromRGB(60, 15, 0)
    },
    ["Blue"] = {
        MainColor = Color3.fromRGB(0, 20, 50),
        SideColor = Color3.fromRGB(0, 10, 30),
        TopColor = Color3.fromRGB(0, 30, 70)
    },
    ["Red"] = {
        MainColor = Color3.fromRGB(50, 0, 0),
        SideColor = Color3.fromRGB(30, 0, 0),
        TopColor = Color3.fromRGB(70, 0, 0)
    },
    ["Water"] = {
        MainColor = Color3.fromRGB(0, 30, 60),
        SideColor = Color3.fromRGB(0, 15, 30),
        TopColor = Color3.fromRGB(0, 45, 90)
    },
    ["Black"] = {
        MainColor = Color3.fromRGB(5, 5, 5),
        SideColor = Color3.fromRGB(0, 0, 0),
        TopColor = Color3.fromRGB(15, 15, 15)
    },
    ["Gray"] = {
        MainColor = Color3.fromRGB(40, 40, 40),
        SideColor = Color3.fromRGB(30, 30, 30),
        TopColor = Color3.fromRGB(50, 50, 50)
    },
    ["Vampire"] = {
        MainColor = Color3.fromRGB(20, 0, 0),
        SideColor = Color3.fromRGB(10, 0, 0),
        TopColor = Color3.fromRGB(30, 0, 0)
    },
    ["Forest"] = {
        MainColor = Color3.fromRGB(10, 30, 10),
        SideColor = Color3.fromRGB(5, 15, 5),
        TopColor = Color3.fromRGB(15, 45, 15)
    },
    ["Gold"] = {
        MainColor = Color3.fromRGB(50, 40, 0),
        SideColor = Color3.fromRGB(30, 25, 0),
        TopColor = Color3.fromRGB(70, 60, 0)
    },
    ["Midnight"] = {
        MainColor = Color3.fromRGB(5, 5, 30),
        SideColor = Color3.fromRGB(2, 2, 15),
        TopColor = Color3.fromRGB(10, 10, 50)
    },
    ["Ghost"] = {
        MainColor = Color3.fromRGB(35, 35, 45),
        SideColor = Color3.fromRGB(25, 25, 30),
        TopColor = Color3.fromRGB(45, 45, 60)
    },
    ["Light"] = {
        MainColor = Color3.fromRGB(240, 240, 240),
        SideColor = Color3.fromRGB(220, 220, 220),
        TopColor = Color3.fromRGB(255, 255, 255)
    },
    ["Shadow"] = {
        MainColor = Color3.fromRGB(10, 10, 12),
        SideColor = Color3.fromRGB(5, 5, 7),
        TopColor = Color3.fromRGB(20, 20, 25)
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
