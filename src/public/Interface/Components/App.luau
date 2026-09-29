--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Vide = require(ReplicatedStorage.Packages.Vide)
local create = Vide.create


function App()
    return create "ScreenGui" {
        Name = "App",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

        -- We'll add children here
    }
end

return App