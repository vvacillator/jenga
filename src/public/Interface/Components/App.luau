--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

local Layer = require("./Elements/Layer")

function App()
    return Layer {
        name = "App",
        displayOrder = 1,
        children = nil
    }
end

return App