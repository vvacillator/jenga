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
        children = {
            Test = e("Frame", {
                Name = "Test",
                Size = UDim2.fromScale(0.15, 0.15),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }, {})
        }
    }
end

return App