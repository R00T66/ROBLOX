local Games = {6032399813, 5735553160}

repeat
    wait()
until game.IsLoaded
repeat
    wait()
until game.Players.LocalPlayer

local Gems = {}
local LegendaryWeapons = {}
local Dictionary = {
    "Bloodless Gem",
    "Blessed Gem",
    "Insignia Gem",
    "Wayward Gem",
    "Blue Gem",
    "Wind Gem"
}
local Players = game:GetService("Players")
local Notifications = nil
local Success, Returns = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/R00T66/INF/main/Dependants/NUI")

if Success then
    Notifications = loadstring(Returns)()
else
    return
end

local count_gems = function(backpack)
    local Gem_Info = {
        ["Bloodless"] = {},
        ["Wayward"] = {},
        ["Insignia"] = {},
        ["Blessed"] = {},
        ["Blue"] = {},
        ["Wind"] = {}
    }

    for i, v in pairs(backpack:GetChildren()) do
        if v.Name == "Bloodless Gem" then
            table.insert(
                Gem_Info.Bloodless,
                {
                    Gem = v,
                    Notified = false
                }
            )
        elseif v.Name == "Wayward Gem" then
            table.insert(
                Gem_Info.Wayward,
                {
                    Gem = v,
                    Notified = false
                }
            )
        elseif v.Name == "Insignia Gem" then
            table.insert(
                Gem_Info.Insignia,
                {
                    Gem = v,
                    Notified = false
                }
            )
        elseif v.Name == "Blessed Gem" then
            table.insert(
                Gem_Info.Blessed,
                {
                    Gem = v,
                    Notified = false
                }
            )
        elseif v.Name == "Blue Gem" then
            table.insert(
                Gem_Info.Blue,
                {
                    Gem = v,
                    Notified = false
                }
            )
        elseif v.Name == "Wind Gem" then
            table.insert(
                Gem_Info.Wind,
                {
                    Gem = v,
                    Notified = false
                }
            )
        end
    end

    return Gem_Info
end
local refresh_gems = function()
    for i, v in pairs(Gems) do
        local Exists = false

        if Players:FindFirstChild(i) then
            Exists = true
        end

        if not Exists then
            table.remove(Gems, i)
        elseif Exists then
            for z, x in pairs(v) do
                if enabled(z) then
                    if not x.Notified then
                        Notifications.GemNotification(i, z .. " Gem")
                    end
                end
            end
        end
    end
end
local refresh_legs = function()
   for i, v in pairs(LegendaryWeapons) do
      if Players:FindFirstChild(v.Own) then
         local Player = Players:FindFirstChild(v.Own)

         if Player.Character then
            if v.Item.Parent == Player.Character then
               table.remove(LegendaryWeapons, i)
            end
         end
      else
         table.remove(LegendaryWeapons, i)
      end
   end
end
local islegendary = function(name)
   name = name:lower()

   local legendary = false 
   local legendary_name = ""

   if string.sub(name, 1, 12) == "curved blade" then
      legendary = true;
      legendary_name = "Curved Blade Of Winds";
   end

   if string.sub(name, 1, 10) == "crypt blade" then
      legendary = true;
      legendary_name = "Crypt Blade";     
   end

   return {
    Value = legendary,
    LName = legendary_name
   }
end
local legendaryreg = function(reg)
   
   local b = false

   for i, v in pairs(LegendaryWeapons) do
      if v.Reg == reg then
         b = true
      end
   end
  
   return b
end
local check_backpack = function(player)
    if player:FindFirstChild("Backpack") then
        local Backpack = player.Backpack
        local GemInfo = nil

        for i, v in pairs(Backpack:GetChildren()) do
            if table.find(Dictionary, v.Name) then
                GemInfo = count_gems(Backpack)

                break
            end
        end

        for i, v in pairs(Backpack:GetChildren()) do
            if islegendary(v.Name).Value then
                local sp = string.split(v.Name, "$")[2]
                local le = islegendary(v.Name).LName

                if not legendaryreg(sp) and enabled(le) then
                    table.insert(LegendaryWeapons, {
                      Reg = sp,
                      Item = v,
                      Own = player.Name
                    })

                    Notifications.LegendaryNotification(i, le)
                end
            end
        end

        Gems[player.Name] = GemInfo
    end
end
local config = function()
    while wait(.5) do
        for i, v in pairs(Players:GetPlayers()) do
            check_backpack(v)
        end
	  refresh_legs()
        refresh_gems()
    end
end
local run = coroutine.create(config)

coroutine.resume(run)
