--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jolt = require(ReplicatedStorage.Packages.Jolt)
local CharmSync = require(ReplicatedStorage.Packages.CharmSync)

local Shared = ReplicatedStorage.Shared
local Store = require(Shared.Store)

local Remote = Jolt.Client "Sync"

local Players = game:GetService("Players")

CharmSync.client.addSignals({
    [`account-{Players.LocalPlayer.Name}`] = Store.AppStore.setAccount,
    ramp = Store.AppStore.setRampAngle,
})

Remote:Connect(function(updates)
    CharmSync.client.patch(updates)
end)