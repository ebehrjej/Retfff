_G.FexawThemes = {
    ["Neon"] = {
        MainColor = Color3.fromRGB(25, 0, 35),
        SideColor = Color3.fromRGB(15, 0, 25),
        TopColor = Color3.fromRGB(80, 0, 120)
    },
    ["Toxic"] = {
        MainColor = Color3.fromRGB(10, 35, 10),
        SideColor = Color3.fromRGB(5, 20, 5),
        TopColor = Color3.fromRGB(120, 255, 0)
    },
    ["Fire"] = {
        MainColor = Color3.fromRGB(35, 10, 5),
        SideColor = Color3.fromRGB(20, 5, 0),
        TopColor = Color3.fromRGB(255, 80, 0)
    },
    ["Blue"] = {
        MainColor = Color3.fromRGB(10, 25, 50),
        SideColor = Color3.fromRGB(5, 15, 30),
        TopColor = Color3.fromRGB(0, 170, 255)
    },
    ["Red"] = {
        MainColor = Color3.fromRGB(40, 5, 5),
        SideColor = Color3.fromRGB(25, 0, 0),
        TopColor = Color3.fromRGB(255, 50, 50)
    },
    ["Water"] = {
        MainColor = Color3.fromRGB(10, 30, 45),
        SideColor = Color3.fromRGB(5, 15, 25),
        TopColor = Color3.fromRGB(0, 200, 255)
    },
    ["Black"] = {
        MainColor = Color3.fromRGB(10, 10, 10),
        SideColor = Color3.fromRGB(5, 5, 5),
        TopColor = Color3.fromRGB(25, 25, 25)
    },
    ["Gray"] = {
        MainColor = Color3.fromRGB(45, 45, 45),
        SideColor = Color3.fromRGB(30, 30, 30),
        TopColor = Color3.fromRGB(80, 80, 80)
    },
    ["Vampire"] = {
        MainColor = Color3.fromRGB(25, 0, 10),
        SideColor = Color3.fromRGB(15, 0, 5),
        TopColor = Color3.fromRGB(150, 0, 0)
    },
    ["Forest"] = {
        MainColor = Color3.fromRGB(15, 35, 15),
        SideColor = Color3.fromRGB(10, 20, 10),
        TopColor = Color3.fromRGB(0, 120, 60)
    },
    ["Gold"] = {
        MainColor = Color3.fromRGB(45, 35, 10),
        SideColor = Color3.fromRGB(30, 25, 5),
        TopColor = Color3.fromRGB(255, 200, 0)
    },
    ["Midnight"] = {
        MainColor = Color3.fromRGB(10, 10, 35),
        SideColor = Color3.fromRGB(5, 5, 20),
        TopColor = Color3.fromRGB(80, 80, 200)
    },
    ["Ghost"] = {
        MainColor = Color3.fromRGB(40, 40, 50),
        SideColor = Color3.fromRGB(25, 25, 35),
        TopColor = Color3.fromRGB(120, 120, 160)
    },
    ["Light"] = {
        MainColor = Color3.fromRGB(235, 235, 235),
        SideColor = Color3.fromRGB(210, 210, 210),
        TopColor = Color3.fromRGB(255, 255, 255)
    },
    ["Shadow"] = {
        MainColor = Color3.fromRGB(15, 15, 20),
        SideColor = Color3.fromRGB(8, 8, 12),
        TopColor = Color3.fromRGB(50, 50, 70)
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
