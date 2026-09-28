--!strict
-- Ayden
-- Sep 27th, 2026

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

local function useTopbarInset(): Rect
	local inset, setInset = React.useState(GuiService.TopbarInset)

	React.useEffect(function()
		local connection = GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
			setInset(GuiService.TopbarInset)
		end)

		setInset(GuiService.TopbarInset)

		return function()
			connection:Disconnect()
		end
	end, {})

	return inset
end

return useTopbarInset