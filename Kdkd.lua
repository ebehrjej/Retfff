local FexawLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ebehrjej/Retfff/refs/heads/main/Siriushub.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ebehrjej/Retfff/refs/heads/main/Themes.lua"))()

local GE = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local sRem = GE:WaitForChild("BuySeedStock")
local eRem = GE:WaitForChild("BuyEventShopStock")
local gRem = GE:WaitForChild("BuyGearStock")
local pRem = GE:WaitForChild("BuyPetEgg")

local Menu = FexawLib:Init()
local MainTab = Menu:CreateTab("Main")
local SettingsTab = Menu:CreateTab("Settings")

local Toggles = {}

local function CreateAutoBuy(tab, name, items, type)
    local cat = tab:CreateCategory(name)
    for _, item in pairs(items) do
        Toggles[item] = false
        cat:AddToggle(item, function(state)
            Toggles[item] = state
            task.spawn(function()
                while Toggles[item] do
                    pcall(function()
                        if type == "Seed" then sRem:FireServer("Shop", item)
                        elseif type == "Event" then eRem:FireServer(item, "Easter Seed Shop")
                        elseif type == "Gear" then gRem:FireServer(item)
                        elseif type == "Egg" then pRem:FireServer(item) end
                    end)
                    task.wait(0.3)
                end
            end)
        end)
    end
end

local seeds = {"Carrot", "Strawberry", "Blueberry", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco", "Crimson Thorn", "Zebrazinkle", "Octobloom", "Alien Apple", "Eggsnapper"}
local evs = {"Easter Candy Carrot", "Easter Chocolate Berry", "Easter Gumball", "Easter Liquorice Beaver", "Chocolate Spinkler", "Easter Sugar Melon", "Easter Chocolate Coconut", "Gummy Bear", "Easter Gummy Cactus", "Easter Egg Melon", "Hootsie Roll", "Easter Sour Lemon", "Springtide Egg", "Easter Egg Fruit"}
local gears = {"Magnifying Glass", "Pet Lead", "Trowel", "Recall Wrench", "Trading Ticket", "Friendship Pot", "Harvest Tool", "Favorite Tool", "Cleaning Pet Shard", "Cleaning Spray", "Medium Treat", "Watering Can", "Basic Sprinkler", "Advanced Sprinkler", "Gogly Sprinkler", "Master Sprinkler", "Grandmaster Sprinkler", "Medium Toy", "Levelup Lollipop"}
local eggs = {"Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Jungle Egg"}

CreateAutoBuy(MainTab, "SEEDS SHOP", seeds, "Seed")
CreateAutoBuy(MainTab, "EVENT ITEMS", evs, "Event")
CreateAutoBuy(MainTab, "GEAR & TOOLS", gears, "Gear")
CreateAutoBuy(MainTab, "PET EGGS", eggs, "Egg")

local ThemeCat = SettingsTab:CreateCategory("UI THEMES")
local themeList = {"Neon", "Fire", "Toxic", "Blue", "Rainbow", "Gray", "Black", "Light", "Red", "Water", "Vampire", "Forest", "Gold", "Midnight", "Ghost"}

for _, themeName in pairs(themeList) do
    ThemeCat:AddButton(themeName, function()
        if _G.ApplyFexawTheme then _G.ApplyFexawTheme(themeName) end
    end)
end

