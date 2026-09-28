--!strict
-- Ayden
-- Sep 27th, 2026

_G.__DEV__ = true

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local createRoot = ReactRoblox.createRoot
local createPortal = ReactRoblox.createPortal

local App = require(ReplicatedStorage.App.Interface.Components.App)

local Players = game:GetService("Players");
local Player = Players.LocalPlayer :: Player

local root = createRoot(Instance.new("Folder"))
root:render(createPortal(e(App), Player:WaitForChild("PlayerGui", 180) :: PlayerGui))

return nil