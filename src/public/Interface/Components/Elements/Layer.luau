--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

type Props = {
    displayOrder: number?,
    children: any?,
    name: string?
}

function Layer(props: Props)
    return e("ScreenGui", {
        Name = props.name or "UI",
        DisplayOrder = props.displayOrder,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, props.children)
end

return Layer