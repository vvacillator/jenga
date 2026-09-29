--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Vide = require(ReplicatedStorage.Packages.Vide)
local mount = Vide.mount

local App = require(ReplicatedStorage.App.Interface.Components.App)

local Players = game:GetService("Players");
local Player = Players.LocalPlayer :: Player

mount(App, Player:WaitForChild("PlayerGui", 180) :: PlayerGui)

return nil